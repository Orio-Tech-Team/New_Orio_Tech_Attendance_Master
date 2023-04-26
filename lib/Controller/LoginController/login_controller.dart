// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orio_tech_attendance_app/Models/login_model.dart';
import 'package:orio_tech_attendance_app/Network/network.dart';
import 'package:orio_tech_attendance_app/Screens/OTP%20Screen/otp_screen.dart';
import 'package:orio_tech_attendance_app/Utils/Constant/text_context.dart';
import '../../Network/Network Manager/network_manager.dart';
import '../../Utils/Snack Bar/custom_snack_bar.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends NetworkManager {
  final TextEditingController idController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  LoginModel? loginModel;
  final box = GetStorage();

  void onSubmit() async {
    box.remove('user_name');
    box.remove('user_phone');
    box.remove('user_token');
    box.remove('user_otp');
    box.remove('user_verify');
    box.remove('user_id');
    box.remove('station_latitude');
    box.remove('station_longitude');
    box.remove('station_radius');
    String? deviceId = await PlatformDeviceId.getDeviceId;
    final form = formKey.currentState;
    if (form!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      var data = {
        "user_name": idController.text.toString(),
        "application_tag": 'ORIO-ATT-APP',
        "device_id": deviceId
      };
      if (idController.text != '') {
        isLoading.value = true;
        Network.postApi(null, AUTH_URL, data).then(
          (value) {
            if (value != null) {
              if (value['message'][0] != "Invalid Username") {
                loginModel = LoginModel.fromJson(value);
                if (loginModel!.status == 200) {
                  box.write('user_name', loginModel!.data.name);
                  box.write('user_phone', loginModel!.data.phone);
                  box.write('user_token', loginModel!.data.token);
                  box.write('user_otp', loginModel!.data.otp);
                  box.write('user_id', idController.text);
                  idController.text = '';
                  Get.toNamed(
                    OTPScreen.routeName,
                  );
                  isLoading.value = false;
                  loginModel = null;
                } else {
                  customSnackBar("Login Failed!!", loginModel!.message[0]);
                  isLoading.value = false;
                }
              } else {
                isLoading.value = false;
                customSnackBar("Error", 'Incorrect User I\'d');
              }
            } else {
              isLoading.value = false;
            }
          },
        );
        form.save();
      }
    }
  }
}
