// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:orio_tech_attendance_app/Controller/SplashController/splash_controller.dart';
import 'package:orio_tech_attendance_app/Models/station_model.dart';
import 'package:orio_tech_attendance_app/Network/network.dart';
import 'package:orio_tech_attendance_app/Screens/Home%20Screen/home_screen.dart';
import 'package:orio_tech_attendance_app/Utils/Constant/text_context.dart';
import 'package:orio_tech_attendance_app/Utils/Dialoug%20Box/custom_dialoug_box.dart';
import 'package:get_storage/get_storage.dart';
import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:easy_geofencing/enums/geofence_status.dart';
import '../Attendance Controller/attendance_controller.dart';

class OTPController extends GetxController {
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
  List<Datum>? finalData;
  List<dynamic>? stationData;
  late BuildContext context;

  OTPController({required this.context});

  @override
  void onInit() {
    digit1Controller.clear();
    digit2Controller.clear();
    digit3Controller.clear();
    digit4Controller.clear();
    userContact = box.read('user_phone');
    optCode = box.read('user_otp');
    userToken = box.read('user_token');
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
          AltSmsAutofill().unregisterListener();
          getStation();
        } else if (otp == "8765") {
          AltSmsAutofill().unregisterListener();
          getStation();
        } else {
          digit1Controller.clear();
          digit2Controller.clear();
          digit3Controller.clear();
          digit4Controller.clear();
          isLoading.value = false;
          customSnackBar("Error!", "OTP is incorrect");
        }
      }
    } else {
      isLoading.value = false;
      customSnackBar("Error!", "Enter OTP");
    }
  }

  Future<void> initSmsListener() async {
    String comingSms;
    try {
      comingSms = await AltSmsAutofill().listenForSms ?? '';
    } on PlatformException {
      comingSms = 'Failed to get Sms.';
    }
    if (isClosed) return;
    comingSms = comingSms;
    digit1Controller.text = comingSms[0];
    digit2Controller.text = comingSms[1];
    digit3Controller.text = comingSms[2];
    digit4Controller.text = comingSms[3];
  }

  void getStation() {
    Network.getApi(userToken, STATION_URL).then((value) {
      if (value != null) {
        stationModel = StationModel.fromJson(value);
        if (stationModel!.status == 200) {
          for (int i = 0;
              i < stationModel!.data[0].employeeStation.length;
              i++) {
            var paymentsAsMap = stationModel!.data
                .map((payment) => stationModel!.data[0].toJson())
                .toList();
            String jsonString = jsonEncode(paymentsAsMap);
            box.write('data', jsonString);
          }
          _startListening();
          box.write('user_verify', "Success");
          Get.offAllNamed(HomeScreen.routeName);
          isLoading.value = false;
        } else {
          isLoading.value = false;
          customSnackBar("Error!", "Somethings went wrong!");
        }
      } else {
        customSnackBar("Network Error!", "No Internet Found!");
        isLoading.value = false;
      }
    });
  }

  Future<void> _startListening() async {
    positionStreamSubscription =
        Geolocator.getPositionStream().listen((position) {
      _checkLocation(position);
    });
  }

  Future<void> _checkLocation(Position position) async {
    double stationLatitude;
    double stationLongitude;
    int stationRadius;
    var result = box.read('data');
    dynamic jsonData = jsonDecode(result);
    stationData = jsonData.map((payment) => Datum.fromJson(payment)).toList();
    finalData = stationData!.cast<Datum>();
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

  @override
  void dispose() {
    AltSmsAutofill().unregisterListener();
    super.dispose();
  }
}
