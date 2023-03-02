import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orio_tech_attendance_app/Controller/LoginController/login_controller.dart';
import 'package:orio_tech_attendance_app/Utils/Colors/color_resource.dart';
import 'package:orio_tech_attendance_app/Widgets/TextField/text_field_container.dart';

import '../../Widgets/Button/button.dart';
import '../../Widgets/TextField/transparent_text_field.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';
  LoginScreen({Key? key}) : super(key: key);
  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: loginBody(),
    );
  }
}

Widget loginBody(){
  LoginController loginController = Get.put(LoginController());
  return Container(
    constraints: const BoxConstraints.expand(),
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/login.png"),
        fit: BoxFit.cover,
      ),
    ),
    child: Form(
      key: loginController.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Login Now',
            style: TextStyle(
              color: Colors.white,
              fontSize: 38,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Please enter the details below to continue.',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 44),
          TextFieldContainer(
            child: TransparentTextField(
              controller: loginController.idController,
              hintText: 'Employee ID',
              keyboardType: TextInputType.number,
              onChange: (value) {},
            ),
          ),
          const SizedBox(height: 20),
          Obx(() {
            if(loginController.isLoading.value == true){
              return const CircularProgressIndicator(color: kPrimaryColor,);
            }else{
              return Button(
                child:
                const Text('Login', style: TextStyle(fontSize: 18)),
                onPressed: () => loginController.onSubmit(),
              );
            }
          }),
        ],
      ),
    ),
  );
}