import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:orio_tech_attendance_app/Models/get_attendance_model.dart';
import 'package:orio_tech_attendance_app/Models/get_employee_attendance_model.dart';
import 'package:orio_tech_attendance_app/Network/network.dart';
import 'package:orio_tech_attendance_app/Utils/Constant/text_context.dart';
import '../../Models/station_model.dart';
import '../../Utils/Dialoug Box/custom_dialoug_box.dart';
import 'package:easy_geofencing/enums/geofence_status.dart';
import 'package:easy_geofencing/easy_geofencing.dart';
import 'package:location/location.dart';
StreamSubscription<GeofenceStatus>? geofenceStatusStream;
RxBool isInRange = false.obs;
class AttendanceController extends GetxController{
  RxBool isRoute = false.obs;
  //RxBool isInRange = false.obs;
  RxBool isLoading = false.obs;
  RxBool isCallOnce = false.obs;
  DateTime date = DateTime.now();

  Timer? timer;
  final box = GetStorage();
  String? stationLatitude;
  String? stationLongitude;
  var stationRadius;
  String? userToken;
  final dateNow = DateFormat('hh:mm').format(DateTime.now());
  GetAttendanceModel? getAttendanceModel;
  RxBool isCheckIn = false.obs;
  DateTime selectedYear = DateTime.now();
  GetEmployeeAttendanceModel? getEmployeeAttendanceModel;
  StationModel? stationModel;


  @override
  void onInit() {
    checkLocation();
    stationLatitude = box.read('station_latitude');
    stationLongitude = box.read('station_longitude');
    stationRadius = box.read('station_radius');
    userToken = box.read('user_token');
    getEmployeeAttendance();
    super.onInit();
  }

  @override
  void dispose() {
    //start();
    super.dispose();
  }

  @override
  void onClose() {
    //start();
    super.onClose();
  }

  checkLocation()async{
    var location = Location();
    bool enabled = await location.serviceEnabled();
    print('==============> LOCATION $enabled');
    if(enabled == false){
      isInRange.value = false;
    }
  }

   start() async {
     //isLoading.value = true;
     EasyGeofencing.startGeofenceService(
         pointedLatitude: stationLatitude!,
         pointedLongitude: stationLongitude!,
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
     getEmployeeAttendance();
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


  void getAttendance(){
    isLoading.value = true;
    Network.getApi(userToken, ATTENDANCE_URL).then((value) {
      if(value != null){
        getAttendanceModel = GetAttendanceModel.fromJson(value);
        if(getAttendanceModel!.status == 200){
          getEmployeeAttendance();
          // customSnackBar("Success", "Your attendance is submitted");
        }else{
          isLoading.value = false;
          customSnackBar("Error",'Somethimg went wrong!');
        }
      }else{
        isLoading.value = false;
        customSnackBar("Network Error",'No Internet not found!');
      }

    });
  }
  
   getEmployeeAttendance(){
    isLoading.value = true;
    Network.getApi(userToken, EMPLOYEE_ATTENDANCE_URL).then((value) {
      if(value != null){
        if(value['data']['id'] != null){
          getAttendanceModel = GetAttendanceModel.fromJson(value);
          if(getAttendanceModel!.status == 200){
            isLoading.value = false;
            //customSnackBar("Updated", "attendance is get");
          }else{
            customSnackBar("Error",'Something went wrong!');
            isLoading.value = false;
            //customSnackBar("Error",'getEmployeeAttendance');
          }
        }else{
          isLoading.value = false;
        }
      }else{
        isLoading.value = false;
        customSnackBar("Network Error",'No Internet found!');
      }


    });
  }


  @override
  void onReady() {
   // start();
    super.onReady();
  }

}