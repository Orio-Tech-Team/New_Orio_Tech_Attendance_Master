import 'dart:async';

import 'package:flutter/material.dart';
import '../../Controller/Attendance Controller/attendance_controller.dart';
import '../../Utils/Layout/layout_screen.dart';
import 'home_body_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:easy_geofencing/easy_geofencing.dart';
import 'package:easy_geofencing/enums/geofence_status.dart';
import 'package:get_storage/get_storage.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
   HomeScreen({Key? key}) : super(key: key);
  static String id = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  String? stationLatitude;
  String? stationLongitude;
  final box = GetStorage();
  @override
  void initState() {
    // TODO: implement initState
    stationLatitude = box.read('station_latitude');
    stationLongitude = box.read('station_longitude');
    //start();
    super.initState();
  }
  start() async {
    //isLoading.value = true;
    EasyGeofencing.startGeofenceService(
        pointedLatitude: stationLatitude!,
        pointedLongitude: stationLongitude!,
        radiusMeter: '100.0',
        eventPeriodInSeconds: 5);
    var locationStatus;
    if(locationStatus == "GeofenceStatus.init"){
      geofenceStatusStream = EasyGeofencing.getGeofenceStream()!
          .listen((GeofenceStatus status) {
        print(status.toString());
         locationStatus = status.toString();
        if(locationStatus == "GeofenceStatus.enter"){
          isInRange.value = true;
        }else if(locationStatus == "GeofenceStatus.init"){
          setState(() {
            isInRange.value = false;
          });
        }else{
          start();
          isInRange.value = false;
        }
      });
    }
    else if (geofenceStatusStream == null) {
      geofenceStatusStream = EasyGeofencing.getGeofenceStream()!
          .listen((GeofenceStatus status) {
        print(status.toString());
         locationStatus = status.toString();
        if(locationStatus == "GeofenceStatus.enter"){
          isInRange.value = true;
        }else if(locationStatus == "GeofenceStatus.init"){
          setState(() {
            isInRange.value = false;
          });
        }else{
          start();
          isInRange.value = false;
        }
      });
    }
    //getEmployeeAttendance();
    /*isInRange.value = false;
    isLoading.value = true;
    Position? position;
    await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then((Position pos) {
      position = pos;
    }).catchError((e) {});
    double distanceInMeters = 0.0;
    distanceInMeters = Geolocator.distanceBetween(
      position?.latitude ?? 0,
      position?.longitude ?? 0,
      double.parse(stationLatitude!),
      double.parse(stationLongitude!),
    );
    if (distanceInMeters <= 150.0) {
      isInRange.value = true;
    }
    getEmployeeAttendance();
    await Future.delayed(const Duration(seconds: 1));*/
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
