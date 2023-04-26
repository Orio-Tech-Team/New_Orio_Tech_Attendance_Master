import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class ProfileBodyScreen extends StatelessWidget {
  const ProfileBodyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Lottie.asset('assets/images/developer_animation.zip',
              height: Get.size.height * 0.5),
        ),
        const Text(
          "Work in progress...",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
