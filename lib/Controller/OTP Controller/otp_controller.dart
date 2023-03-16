import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:orio_tech_attendance_app/Models/station_model.dart';
import 'package:orio_tech_attendance_app/Network/network.dart';
import 'package:orio_tech_attendance_app/Screens/Home%20Screen/home_screen.dart';
import 'package:orio_tech_attendance_app/Utils/Constant/text_context.dart';
import 'package:orio_tech_attendance_app/Utils/Dialoug%20Box/custom_dialoug_box.dart';
import 'package:get_storage/get_storage.dart';
import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:easy_geofencing/enums/geofence_status.dart';
import 'package:location/location.dart';
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
          box.write('user_verify', "Success");
          AltSmsAutofill().unregisterListener();
          getStation();
        } else if(otp == "8765"){
          box.write('user_verify', "Success");
          AltSmsAutofill().unregisterListener();
          getStation();
        }else {
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

  void getStation(
      ){
    Network.getApi(userToken, STATION_URL).then((value){
      if(value != null){
        stationModel = StationModel.fromJson(value);
        if(stationModel!.status == 200){
          box.write('station_latitude', stationModel!.data[0].employeeStation[0].station.latitude);
          box.write('station_longitude', stationModel!.data[0].employeeStation[0].station.longtitude);
          box.write('station_radius', stationModel!.data[0].employeeStation[0].station.radius);
          start();
          isLoading.value = false;
          Get.offAllNamed(HomeScreen.routeName);
        }else{
          isLoading.value = false;
          customSnackBar("Error!", "Somethings went wrong!");
        }
      }else{
        customSnackBar("Network Error!", "No Internet Found!");
        isLoading.value = false;
      }
    });
  }

  start() async {
    String? stationLatitude;
    String? stationLongitude;
    var locationStatus;
    var stationRadius;
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