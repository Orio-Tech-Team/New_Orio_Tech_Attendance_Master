import 'package:flutter/material.dart';
import 'package:orio_tech_attendance_app/Screens/Desk%20Screen/desk_screen.dart';
import 'package:orio_tech_attendance_app/Screens/Home%20Screen/home_screen.dart';
import 'package:orio_tech_attendance_app/Screens/Notification%20Screen/notification_screen.dart';
import 'package:orio_tech_attendance_app/Screens/Profile%20Screen/profile_screen.dart';
import 'package:orio_tech_attendance_app/Widgets/Button/navigation_button.dart';
import 'package:get/get.dart';

import '../../Utils/Routes/navigate.dart';

class LayoutBottomBar extends StatefulWidget {
  final int currentTab;

  const LayoutBottomBar({super.key, required this.currentTab});

  @override
  State<LayoutBottomBar> createState() => _LayoutBottomBarState();
}

class _LayoutBottomBarState extends State<LayoutBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 18.0,
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NavigationButton(
                  onPressed: () => Get.toNamed(HomeScreen.routeName),
                  //Navigate.to(context,HomeScreen.routeName),
                  icon: 'assets/icons/home.svg',
                  text: 'Home',
                  tab: 1,
                  currentTab: widget.currentTab,
                ),
                NavigationButton(
                  onPressed: () {},
                  //=> Navigate.to(context,DeskScreen.routeName),
                  icon: 'assets/icons/hr_bottom.svg',
                  text: 'HR desk',
                  tab: 2,
                  isDisabled: true,
                  currentTab: widget.currentTab,
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NavigationButton(
                  onPressed: () => Get.toNamed(NotificationScreen.routeName),
                  //Navigate.to(context,NotificationScreen.routeName),
                  icon: 'assets/icons/notification.svg',
                  text: 'Notification',
                  tab: 3,
                  isDisabled: false,
                  currentTab: widget.currentTab,
                ),
                NavigationButton(
                  onPressed: () {},
                  //=> Navigate.to(context,ProfileScreen.routeName),
                  icon: 'assets/icons/profile.svg',
                  text: 'Profile',
                  tab: 4,
                  isDisabled: true,
                  currentTab: widget.currentTab,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
