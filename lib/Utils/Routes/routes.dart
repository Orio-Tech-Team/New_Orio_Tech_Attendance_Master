import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orio_tech_attendance_app/Screens/Attendance%20Screen/Attendance%20Data%20Screen/attendance_data_screen.dart';
import 'package:orio_tech_attendance_app/Screens/Attendance%20Screen/attendance_screen.dart';
import 'package:orio_tech_attendance_app/Screens/Bottom%20Navigation%20Screen/bottom_navigation_screen.dart';
import 'package:orio_tech_attendance_app/Screens/Desk%20Screen/Request%20Attendance%20Screen/request_attendance_screen.dart';
import 'package:orio_tech_attendance_app/Screens/Desk%20Screen/desk_screen.dart';
import 'package:orio_tech_attendance_app/Screens/Home%20Screen/home_screen.dart';
import 'package:orio_tech_attendance_app/Screens/Login%20Screen/login_screen.dart';
import 'package:orio_tech_attendance_app/Screens/Notification%20Screen/notification_screen.dart';
import 'package:orio_tech_attendance_app/Screens/OTP%20Screen/otp_screen.dart';
import 'package:orio_tech_attendance_app/Screens/Profile%20Screen/profile_screen.dart';
import 'package:orio_tech_attendance_app/Screens/Splash%20Screen/splash_screen.dart';
import 'package:orio_tech_attendance_app/Utils/Layout/layout_screen.dart';


final List<GetPage<dynamic>> routes = [
  GetPage(
    name: SplashScreen.routeName,
    page: () =>  SplashScreen(),
  ),
  GetPage(
    name: LoginScreen.routeName,
    page: () =>  LoginScreen(),
  ),
  GetPage(
    name: OTPScreen.routeName,
    page: () => const OTPScreen(),
  ),
  GetPage(
    name: HomeScreen.routeName,
    page: () =>  HomeScreen(),
  ),
  GetPage(
    name: AttendanceScreen.routeName,
    page: () => const AttendanceScreen(),
  ),
  GetPage(
    name: AttendanceDataScreen.routeName,
    page: () => const AttendanceDataScreen(),
  ),
  GetPage(
    name: NotificationScreen.routeName,
    page: () => const NotificationScreen(),
  ),
  GetPage(
    name: ProfileScreen.routeName,
    page: () => const ProfileScreen(),
  ),
  GetPage(
    name: DeskScreen.routeName,
    page: () => const DeskScreen(),
  ),
  GetPage(
    name: RequestAttendanceScreen.routeName,
    page: () => const RequestAttendanceScreen(),
  ),
  GetPage(
    name: BottomNavigationScreen.routeName,
    page: () => const BottomNavigationScreen(),
  ),
];

class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    SplashScreen.routeName: (context) =>  SplashScreen(),
    LoginScreen.routeName: (context) =>  LoginScreen(),
    HomeScreen.routeName: (context) =>  HomeScreen(),
    NotificationScreen.routeName: (context) => const NotificationScreen(),
    AttendanceScreen.routeName: (context) => const AttendanceScreen(),
    AttendanceDataScreen.routeName: (context) => const AttendanceDataScreen(),
  };
}