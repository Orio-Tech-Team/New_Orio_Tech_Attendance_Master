import 'dart:async';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:easy_geofencing/enums/geofence_status.dart';
import 'package:easy_geofencing/easy_geofencing.dart';
import '../../Controller/Attendance Controller/attendance_controller.dart';
import '../../Screens/Attendance Screen/attendance_screen.dart';

class LayoutFAB extends StatelessWidget {
  LayoutFAB({Key? key}) : super(key: key);
  String? stationLatitude;
  String? stationLongitude;
  var stationRadius;
  final box = GetStorage();

  start() async {
    stationLatitude = box.read('station_latitude');
    stationLongitude = box.read('station_longitude');
    stationRadius = box.read('station_radius');
    EasyGeofencing.startGeofenceService(
        pointedLatitude: stationLatitude!,
        pointedLongitude: stationLongitude!,
        radiusMeter: stationRadius.toString(),
        eventPeriodInSeconds: 0);
    geofenceStatusStream ??=
        EasyGeofencing.getGeofenceStream()!.listen((GeofenceStatus status) {
      var locationStatus = status.toString();
      if (locationStatus == "GeofenceStatus.enter") {
        isInRange.value = true;
      } else {
        isInRange.value = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        //start();
        Get.toNamed(AttendanceScreen.routeName);
      }, //Navigate.to(context, AttendanceScreen.id),
      child: SvgPicture.asset('assets/icons/time.svg'),
    );
  }
}
