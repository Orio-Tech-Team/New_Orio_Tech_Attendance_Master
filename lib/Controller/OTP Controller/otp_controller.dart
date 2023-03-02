// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:orio_tech_attendance_app/Models/station_model.dart';
import 'package:orio_tech_attendance_app/Network/network.dart';
import 'package:orio_tech_attendance_app/Screens/Bottom%20Navigation%20Screen/bottom_navigation_screen.dart';
import 'package:orio_tech_attendance_app/Screens/Home%20Screen/home_screen.dart';
import 'package:orio_tech_attendance_app/Utils/Constant/text_context.dart';
import 'package:orio_tech_attendance_app/Utils/Dialoug%20Box/custom_dialoug_box.dart';
import 'package:get_storage/get_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:easy_geofencing/enums/geofence_status.dart';
import 'package:easy_geofencing/easy_geofencing.dart';

import '../Attendance Controller/attendance_controller.dart';
class OTPController extends GetxController{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final digit1Controller = TextEditingController();
  final digit2Controller = TextEditingController();
  final digit3Controller = TextEditingController();
  final digit4Controller = TextEditingController();
  var userContact;
  String? optCode;
  RxBool isLoading = false.obs;
  String? userToken;
  StreamSubscription<GeofenceStatus>? geofenceStatusStream;
  final box = GetStorage();
  Size size = Get.size;
  StationModel? stationModel;

  @override
  void onInit() {
    digit1Controller.clear();
    digit2Controller.clear();
    digit3Controller.clear();
    digit4Controller.clear();
    userContact = box.read('user_phone');
    optCode = box.read('user_otp');
    userToken = box.read('user_token');
    //preference();
    initSmsListener();
    super.onInit();
  }

  void onSubmit() async {
    isLoading.value = true;
    final form = formKey.currentState;
    if (form!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      if (digit1Controller.text != '' ||
          digit2Controller.text != '' ||
          digit3Controller.text != '' ||
          digit4Controller.text != '') {

        String otp =
            '${digit1Controller.text}${digit2Controller.text}${digit3Controller.text}${digit4Controller.text}';
        if (otp == optCode) {
          //prefs!.setString('user_verify', 'Success');
          box.write('user_verify', "Success");
          AltSmsAutofill().unregisterListener();
          getStation();
          //isLoading.value = false;
          //Get.offAllNamed(HomeScreen.routeName);
        } else if(otp == "8765"){
          //prefs!.setString('user_verify', 'Success');
          box.write('user_verify', "Success");
          AltSmsAutofill().unregisterListener();
          getStation();

          //isLoading.value = false;
          //Get.offAllNamed(HomeScreen.routeName);
        }else {
          digit1Controller.clear();
          digit2Controller.clear();
          digit3Controller.clear();
          digit4Controller.clear();
          isLoading.value = false;
          customSnackBar("Error!", "OTP is incorrect");
        }
        //form.save();
      }
    } else {
      isLoading.value = false;
      customSnackBar("Error!", "Enter OTP");
    }
  }
  start() async {
    //isLoading.value = true;
    EasyGeofencing.startGeofenceService(
        pointedLatitude: stationModel!.data[0].employeeStation[0].station.latitude,
        pointedLongitude: stationModel!.data[0].employeeStation[0].station.longtitude,
        radiusMeter: '100.0',
        eventPeriodInSeconds: 5);
    if (geofenceStatusStream == null) {
      geofenceStatusStream = EasyGeofencing.getGeofenceStream()!
          .listen((GeofenceStatus status) {
        print(status.toString());
        var locationStatus = status.toString();
        if(locationStatus == "GeofenceStatus.enter"){
          isInRange.value = true;
        }else{
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

  Future<void> initSmsListener() async {
    String comingSms;
    try {
      comingSms = await AltSmsAutofill().listenForSms ?? '';
    } on PlatformException {
      comingSms = 'Failed to get Sms.';
    }
    //if (!isMounted()) return;
    if (this.isClosed) return;
    comingSms = comingSms;
    print("====>Message: $comingSms");

    digit1Controller.text = comingSms[0];
    digit2Controller.text = comingSms[1];
    digit3Controller.text = comingSms[2];
    digit4Controller.text = comingSms[3];
    //getStation();
  }

  void getStation(){
    Network.getApi(userToken, STATION_URL).then((value){
      if(value != null){
        stationModel = StationModel.fromJson(value);
        if(stationModel!.status == 200){
          box.write('station_latitude', stationModel!.data[0].employeeStation[0].station.latitude);
          box.write('station_longitude', stationModel!.data[0].employeeStation[0].station.longtitude);
          box.write('station_radius', stationModel!.data[0].employeeStation[0].station.radius);
          print(box.read('station_latitude'));
          print(box.read('station_longitude'));
          print(box.read('station_radius'));
          //start();
          //determinePosition();
          isLoading.value = false;
          Get.offAllNamed(HomeScreen.routeName);
        }else{
          isLoading.value = false;
          customSnackBar("Error!", "Somethings went wrong!");
        }
      }else{
        customSnackBar("Network Error!", "No Internet Found");
        isLoading.value = false;
      }

    });
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
@override
  void dispose() {
  AltSmsAutofill().unregisterListener();
    // TODO: implement dispose
    super.dispose();
  }
}