import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

  checkLocation()async{
    var location = Location();
    bool enabled = await location.serviceEnabled();
    if(enabled == false){
      isInRange.value = false;
    }
  }
  void getAttendance(){
    isLoading.value = true;
    Network.getApi(userToken, ATTENDANCE_URL).then((value) {
      if(value != null){
        getAttendanceModel = GetAttendanceModel.fromJson(value);
        if(getAttendanceModel!.status == 200){
          getEmployeeAttendance();
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
          }else{
            customSnackBar("Error",'Something went wrong!');
            isLoading.value = false;
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
}