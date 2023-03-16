import 'dart:async';

import 'package:get/get.dart';
import 'package:orio_tech_attendance_app/Screens/Home%20Screen/home_screen.dart';
import 'package:orio_tech_attendance_app/Screens/Login%20Screen/login_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';
import 'package:easy_geofencing/easy_geofencing.dart';
import 'package:easy_geofencing/enums/geofence_status.dart';

import '../Attendance Controller/attendance_controller.dart';

class SplashController extends GetxController{
  final box = GetStorage();
  String? isVerified;
  StreamSubscription<GeofenceStatus>? geofenceStatusStream;
  String? stationLatitude;
  String? stationLongitude;
  var locationStatus;
  var stationRadius;

  @override
  void onInit() {
    isVerified = box.read('user_verify');
    showSplashDuration();
    super.onInit();
  }

  start() async {
    stationLatitude = box.read('station_latitude');
    stationLongitude = box.read('station_longitude');
    stationRadius = box.read('station_radius');
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
      start();
      Future.delayed(const Duration(seconds: 2), () {
        //start();
        Get.offAllNamed(HomeScreen.routeName);
      });
    }else{
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAllNamed(LoginScreen.routeName);
      });
    }

  }
}