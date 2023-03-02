import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Screens/Attendance Screen/attendance_screen.dart';

class LayoutFAB extends StatelessWidget {
  const LayoutFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Get.toNamed(AttendanceScreen.routeName);
      }, //Navigate.to(context, AttendanceScreen.id),
      child: SvgPicture.asset('assets/icons/time.svg'),
    );
  }
}
