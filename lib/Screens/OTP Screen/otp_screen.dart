import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:orio_tech_attendance_app/Controller/OTP%20Controller/otp_controller.dart';
import 'package:orio_tech_attendance_app/Utils/Colors/color_resource.dart';
import '../../Widgets/Button/button.dart';
import '../../Widgets/TextField/text_field_box.dart';

class OTPScreen extends StatelessWidget {
  static const String routeName = '/otp-screen';
  const OTPScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  otpAppBar(),
      body: otpBody(context),
    );
  }
}
Widget otpBody(BuildContext context){
  OTPController otpController = Get.put(OTPController(context: context));
  return SingleChildScrollView(
    child: GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: otpController.size.height * 0.1),
          height: otpController.size.height * 0.8,
          child: Form(
            key: otpController.formKey,
            child: Column(
              children: [
                SvgPicture.asset('assets/icons/otp.svg'),
                const SizedBox(height: 25),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     const Text(
                      'Code is sent to ',
                      style: TextStyle(
                        color: Color(0xFF6E6E6E),
                      ),
                     ),
                     Text(
                       '${otpController.userContact}',
                       style: const TextStyle(
                         color: Colors.black,
                         fontWeight: FontWeight.bold,
                         fontSize: 16
                       ),
                     ),
                   ],
                 ),
                const SizedBox(height: 44),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFieldBox(
                      controller: otpController.digit1Controller,
                      autofocus: true,
                      onChange: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                    const SizedBox(width: 10),
                    TextFieldBox(
                      controller: otpController.digit2Controller,
                      onChange: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                    const SizedBox(width: 10),
                    TextFieldBox(
                      controller: otpController.digit3Controller,
                      onChange: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                    const SizedBox(width: 10),
                    TextFieldBox(
                      controller: otpController.digit4Controller,
                      onChange: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                          otpController.onSubmit();
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Obx(() => otpController.isLoading.value == false?SizedBox(
                  width: 250,
                  child: Button(
                    child: const Text('Verify'),
                    onPressed: () => otpController.onSubmit(),
                  ),
                ):const CircularProgressIndicator(color: kPrimaryColor,),),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

PreferredSizeWidget otpAppBar(){
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back_outlined,
        color: Color(0xFF404040),
      ),
      onPressed: () => Get.back(),
    ),
    title: const Text(
      'OTP',
      style: TextStyle(color: Color(0xFF404040)),
    ),
  );
}