import 'package:flutter/material.dart';
import 'package:orio_tech_attendance_app/Utils/transition/transition.dart';
import '../Colors/color_resource.dart';

class AppTheme {
  static ThemeData themeData() {
    return ThemeData(
      primaryColor: kPrimaryColor,
      colorScheme: const ColorScheme.light(
        primary: kPrimaryColor,
      ),
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Ubuntu',
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: TransitionsBuilder(),
          TargetPlatform.iOS: TransitionsBuilder(),
        },
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorResources.PRIMARY_COLOR,
      ),
    );
  }
}
