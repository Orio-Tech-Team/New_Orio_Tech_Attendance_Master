import 'package:flutter/material.dart';
import 'package:orio_tech_attendance_app/Screens/Desk%20Screen/Request%20Attendance%20Screen/request_attendance_screen.dart';
import 'package:get/get.dart';
import '../../Widgets/HomeCard/home_card.dart';

class DeskBodyScreen extends StatelessWidget {
  const DeskBodyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 10),
      const Text(
        'HR-DESK',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20.0,
        ),
      ),
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.only(left: 8),
        child: requestAttendanceGrid(),
      )
    ]);
  }
}

Widget requestAttendanceGrid() {
  return GridView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4 / 3,
      ),
      itemCount: 1,
      itemBuilder: (context, index) {
        return GridTile(
          child: HomeCard(
            img: 'assets/icons/request_icon.svg',
            title: 'Request Now',
            route: '',
            onPressed: () {
              Get.toNamed(RequestAttendanceScreen.routeName);
            },
            isDisabled: false,
          ),
        );
      });
}
