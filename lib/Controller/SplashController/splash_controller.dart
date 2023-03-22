import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orio_tech_attendance_app/Screens/Home%20Screen/home_screen.dart';
import 'package:orio_tech_attendance_app/Screens/Login%20Screen/login_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';
import 'package:easy_geofencing/easy_geofencing.dart';
import 'package:easy_geofencing/enums/geofence_status.dart';
import '../../Models/station_model.dart';
import '../../Utils/Dialoug Box/location_dialoug_box.dart';
import '../Attendance Controller/attendance_controller.dart';

class SplashController extends GetxController{
  final box = GetStorage();
  String? isVerified;
  StreamSubscription<GeofenceStatus>? geofenceStatusStream;
  var locationStatus;
  var stationRadius;
  String? stationLatitude;
  String? stationLongitude;
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

  start() async {
    stationLatitude = finalData![0].employeeStation[0].station.latitude;
    stationLongitude = finalData![0].employeeStation[0].station.longtitude;
    stationRadius = finalData![0].employeeStation[0].station.radius;
    try{
      EasyGeofencing.startGeofenceService(
          pointedLatitude: stationLatitude!,
          pointedLongitude: stationLongitude!,
          radiusMeter: stationRadius.toString(),
          eventPeriodInSeconds: 0
      );
      geofenceStatusStream ??= EasyGeofencing.getGeofenceStream()!
          .listen((GeofenceStatus status) async{
        var location = Location();
        bool enabled = await location.serviceEnabled();
        if(enabled == true){
          try{
            locationStatus = status.toString();
            if(locationStatus == "GeofenceStatus.enter"){
              isInRange.value = true;
            }else if(locationStatus == "GeofenceStatus.init"){
              isInRange.value = false;
            }else{
              isInRange.value = false;
            }
          }catch(e){
            isInRange.value = false;
          }
        }else{
          isInRange.value = false;
        }
      });
    }catch(e){
      isInRange.value = false;
    }
  }

  void showSplashDuration() async {
    if(isVerified != null){
      var result = box.read('data');
      dynamic jsonData = jsonDecode(result);
      stationData = jsonData.map((payment) => Datum.fromJson(payment)).toList();
      finalData = stationData!.cast<Datum>();
      if(finalData![0].employeeStation.length == 1){
        start();
        Future.delayed(const Duration(seconds: 2), () {
          Get.offAllNamed(HomeScreen.routeName);
        });
      }else{
        Future.delayed(const Duration(seconds: 1), () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return const LocationDialoug();
            },
          );
        });
      }
    }else{
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAllNamed(LoginScreen.routeName);
      });
    }
  }
}