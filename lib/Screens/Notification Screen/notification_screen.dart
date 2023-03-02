import 'package:flutter/material.dart';


import '../../Utils/Layout/layout_screen.dart';

import 'notification_body_screen.dart';

class NotificationScreen extends StatelessWidget {
  static const String routeName = '/notification-screen';
  const NotificationScreen({Key? key}) : super(key: key);
  static String id = "notification_screen";
  @override
  Widget build(BuildContext context) {
    return const Layout(
      currentTab: 3,
      body: SingleChildScrollView(
        child: NotificationBodyScreen(),
      ),
    );
  }
}
