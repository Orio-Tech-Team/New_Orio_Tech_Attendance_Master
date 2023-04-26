import 'package:flutter/material.dart';
import '../../Utils/Layout/layout_screen.dart';
import 'attendance_body_screen.dart';

class AttendanceScreen extends StatelessWidget {
  static const String routeName = '/attendance-screen';
   const AttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Layout(
      body: AttendanceBodyScreen(),
    );
  }
}
