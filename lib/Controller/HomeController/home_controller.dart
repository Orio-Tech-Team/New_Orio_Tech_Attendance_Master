import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:easy_geofencing/easy_geofencing.dart';
import '../../Utils/Constant/text_context.dart';
import 'package:easy_geofencing/enums/geofence_status.dart';
import 'package:location/location.dart';

import '../Attendance Controller/attendance_controller.dart';
class HomeController extends GetxController{
  RxString greeting = 'Good Morning'.obs;
  final box = GetStorage();
  String? userName;
  StreamSubscription<GeofenceStatus>? geofenceStatusStream;
  String? stationLatitude;
  String? stationLongitude;
  Position? position;
  var locationStatus;
  var stationRadius;

  @override
  void onInit() {
    stationLatitude = box.read('station_latitude');
    stationLongitude = box.read('station_longitude');
    stationRadius = box.read('station_radius');
    userName = box.read('user_name');
    //start();
    setGreeting();
    determinePosition();
    super.onInit();
  }
  void setGreeting() async {
    final now = DateTime.now();
    final hour = now.hour;
    print("Current Hours: $hour");
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

  agree() async {
    if(locationStatus == "GeofenceStatus.init"){
      geofenceStatusStream = EasyGeofencing.getGeofenceStream()!
          .listen((GeofenceStatus status) {
        print(status.toString());
        locationStatus = status.toString();
        if(locationStatus == "GeofenceStatus.enter"){
          isInRange.value = true;
        }else if(locationStatus == "GeofenceStatus.init"){
          isInRange.value = false;
        }else{
          isInRange.value = false;
        }
      });
    }
  }
  start() async {
    try{
      EasyGeofencing.startGeofenceService(
          pointedLatitude: stationLatitude!,
          pointedLongitude: stationLongitude!,
          radiusMeter: stationRadius.toString(),
          eventPeriodInSeconds: 0
      );
      var location = Location();
      bool enabled = await location.serviceEnabled();
      print('==============> LOCATION $enabled');
      geofenceStatusStream ??= EasyGeofencing.getGeofenceStream()!
            .listen((GeofenceStatus status) async{
        var location = Location();
        bool enabled = await location.serviceEnabled();
        print('==============> LOCATION $enabled');
        if(enabled == true){
          try{
            print(status.toString());
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

          //isInRange.value = false;
        });
      //isInRange.value = false;
    }catch(e){
      isInRange.value = false;
    }
    //isLoading.value = true;

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
   // isInRange.value = false;
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

  /*Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }*/
}