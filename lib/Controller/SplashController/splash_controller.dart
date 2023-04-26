// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orio_tech_attendance_app/Screens/Home%20Screen/home_screen.dart';
import 'package:orio_tech_attendance_app/Screens/Login%20Screen/login_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:easy_geofencing/enums/geofence_status.dart';
import '../../Models/station_model.dart';
import '../Attendance Controller/attendance_controller.dart';

late StreamSubscription<Position> positionStreamSubscription;

class SplashController extends GetxController {
  final box = GetStorage();
  String? isVerified;
  StreamSubscription<GeofenceStatus>? geofenceStatusStream;
  var stationLatitude;
  var stationLongitude;
  var locationStatus;
  var stationRadius;
  late BuildContext context;
  StationModel? stationModel;
  List<Datum>? finalData;
  List<dynamic>? stationData;

  SplashController({required this.context});

  @override
  void onInit() {
    isVerified = box.read('user_verify');
    showSplashDuration();
    super.onInit();
  }

  Future<void> _startListening() async {
    positionStreamSubscription =
        Geolocator.getPositionStream().listen((position) {
      _checkLocation(position);
    });
  }

  Future<void> _checkLocation(Position position) async {
    for (int i = 0; i < finalData![0].employeeStation.length; i++) {
      stationLatitude = double.parse(
          finalData![0].employeeStation[i].station.latitude.toString());
      stationLongitude = double.parse(
          finalData![0].employeeStation[i].station.longtitude.toString());
      stationRadius = finalData![0].employeeStation[i].station.radius;
      if (isInRange.value == false) {
        double distanceInMeters = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          stationLatitude,
          stationLongitude,
        );
        if (distanceInMeters <= stationRadius == true) {
          isInRange.value = distanceInMeters <= stationRadius;
          currentRange.value = true;
          currentLattitude = stationLatitude;
          currentLongitude = stationLongitude;
          currentRadius = stationRadius;
          break;
        } else {
          isInRange.value = false;
        }
      } else {
        double distanceInMeters = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          currentLattitude,
          currentLongitude,
        );
        if (distanceInMeters <= currentRadius == true) {
          isInRange.value = distanceInMeters <= currentRadius;
          break;
        } else {
          isInRange.value = false;
        }
      }
    }
  }

  void showSplashDuration() async {
    if (isVerified != null) {
      var result = box.read('data');
      dynamic jsonData = jsonDecode(result);
      stationData = jsonData.map((payment) => Datum.fromJson(payment)).toList();
      finalData = stationData!.cast<Datum>();
      _startListening();
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAllNamed(HomeScreen.routeName);
      });
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAllNamed(LoginScreen.routeName);
      });
    }
  }
}
