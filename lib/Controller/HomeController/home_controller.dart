// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:easy_geofencing/easy_geofencing.dart';
import 'package:easy_geofencing/enums/geofence_status.dart';
import 'package:location/location.dart';
import '../Attendance Controller/attendance_controller.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomeController extends GetxController {
  RxString greeting = 'Good Morning'.obs;
  final box = GetStorage();
  String? userName;
  StreamSubscription<GeofenceStatus>? geofenceStatusStream;
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  RxBool isAlertSet = false.obs;
  String? stationLatitude;
  String? stationLongitude;
  Position? position;
  var locationStatus;
  var stationRadius;
  late BuildContext context;

  HomeController({required this.context});

  @override
  void onInit() {
    stationLatitude = box.read('station_latitude');
    stationLongitude = box.read('station_longitude');
    stationRadius = box.read('station_radius');
    userName = box.read('user_name');
    setGreeting();
    getConnectivity();
    super.onInit();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
            (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet.value == false) {
            showDialogBox();
            isAlertSet.value = true;
          }
        },
      );

  void setGreeting() async {
    final now = DateTime.now();
    final hour = now.hour;
    if (hour < 12) {
      greeting = 'Good Morning'.obs;
    } else if (hour < 18) {
      greeting = 'Good Afternoon'.obs;
    } else if (hour < 21) {
      greeting = 'Good Evening'.obs;
    } else {
      greeting = 'Good Night'.obs;
    }
  }

  Future determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return null;
    }
  }
  showDialogBox() => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('No Connection'),
      content: const Text('Please check your internet connectivity'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'Cancel');
            isAlertSet.value = false;
            isDeviceConnected =
            await InternetConnectionChecker().hasConnection;
            if (!isDeviceConnected && isAlertSet.value == false) {
              showDialogBox();
              isAlertSet.value = true;
            }
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
