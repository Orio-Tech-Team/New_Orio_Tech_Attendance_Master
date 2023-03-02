import 'package:flutter/material.dart';
import '../../../Utils/Layout/layout_screen.dart';
import 'attendance_data_body_screen.dart';

class AttendanceDataScreen extends StatelessWidget {
  static const String routeName = '/attendance-data-screen';
  const AttendanceDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Layout(
      body: SingleChildScrollView(
        child: AttendanceDataBodyScreen(),
      ),
    );
  }
}
