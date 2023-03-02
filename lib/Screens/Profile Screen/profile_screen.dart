import 'package:flutter/material.dart';
import 'package:orio_tech_attendance_app/Screens/Profile%20Screen/profile_body_screen.dart';
import '../../Utils/Layout/layout_screen.dart';


class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile-screen';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Layout(
      currentTab: 4,
      body: SingleChildScrollView(
        child: ProfileBodyScreen(),
      ),
    );
  }
}

