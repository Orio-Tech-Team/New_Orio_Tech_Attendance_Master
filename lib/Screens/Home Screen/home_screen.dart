import 'dart:async';
import 'package:flutter/material.dart';
import '../../Utils/Layout/layout_screen.dart';
import 'home_body_screen.dart';
import 'package:easy_geofencing/enums/geofence_status.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  HomeScreen({Key? key}) : super(key: key);
  static String id = "home_screen";

  DateTime? currentBackPressTime;

  StreamSubscription<GeofenceStatus>? geofenceStatusStream;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: const Layout(
        currentTab: 1,
        body: SingleChildScrollView(
          child: HomeBodyScreen(),
        ),
      ),
    );
  }
}
