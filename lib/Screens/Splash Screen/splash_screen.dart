import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orio_tech_attendance_app/Controller/SplashController/splash_controller.dart';
import 'package:orio_tech_attendance_app/Utils/Colors/color_resource.dart';
import 'package:orio_tech_attendance_app/Utils/Constant/text_context.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder(
        init: SplashController(context: context),
        builder: (_) => Scaffold(
          backgroundColor: ColorResources.PRIMARY_COLOR,
          body: Center(
            child: SvgPicture.asset(SPLASH_LOGO),
          ),
        ),
    );
  }
}
