import 'package:flutter/material.dart';

import 'package:orio_tech_attendance_app/Screens/Desk%20Screen/Request%20Attendance%20Screen/request_attendance_body_screen.dart';

import '../../../Utils/Layout/layout_screen.dart';


class RequestAttendanceScreen extends StatelessWidget {
  static const String routeName = '/request-attendance-screen';
  const RequestAttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const Layout(body: RequestAttendanceBodyScreen());
  }
}

