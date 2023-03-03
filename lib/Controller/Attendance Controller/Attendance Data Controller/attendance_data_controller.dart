import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Models/get_attendance_data.dart';
import '../../../Network/network.dart';
import '../../../Utils/Constant/text_context.dart';
import '../../../Utils/Dialoug Box/custom_dialoug_box.dart';

class AttendanceDataController extends GetxController{
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  DateTime selectedYear = DateTime.now();
  final ItemScrollController scrollController = ItemScrollController();
  RxBool isLoading = false.obs;
  RxBool isSuccess = false.obs;
  String? finalFromDate;
  String? finalToDate;
  final box = GetStorage();
  String? user_id;
  GetAttendanceData? getAttendanceData ;

  Future getData(int monthNo, String token) async {
    String attendanceDate = monthNo < 10
        ? '${selectedYear.year}-0$monthNo'
        : '${selectedYear.year}-$monthNo';
  }

  getFromDate(){
    finalFromDate =
    fromDate.month < 10
        ? fromDate.day < 10
        ? '${fromDate.year}-0${fromDate.month}-0${fromDate.day}'
        :'${fromDate.year}-0${fromDate.month}-${fromDate.day}'
        : fromDate.day < 10
        ? '${fromDate.year}-${fromDate.month}-0${fromDate.day}'
        : '${fromDate.year}-${fromDate.month}-${fromDate.day}';
    print("from date ========> $finalFromDate");
  }
  getToDate(){
    finalToDate = toDate.month < 10
        ? toDate.day < 10
        ? '${toDate.year}-0${toDate.month}-0${toDate.day}'
        :'${toDate.year}-0${toDate.month}-${toDate.day}'
        : toDate.day < 10
        ? '${toDate.year}-${toDate.month}-0${toDate.day}'
        : '${toDate.year}-${toDate.month}-${toDate.day}';
    print("to date ========> $finalToDate");
  }

  void onSubmit() async {
    isLoading.value = true;
    user_id = box.read('user_id');
    getFromDate();
    getToDate();
    //isLoading.value = false;
    var data = {
      "from_date": finalFromDate,
      "to_date": finalToDate,
      "employee_number": user_id,
    };

    Network.postApi(null, POST_ATTENDANCE_DATA, data).then((value) {
      if(value != null){
        getAttendanceData = GetAttendanceData.fromJson(value);
        if(getAttendanceData!.status == 200){
          if(getAttendanceData!.data.isNotEmpty){
            //customSnackBar("Success","Retrived Data Successfull");
            isSuccess.value = true;
            isLoading.value = false;
          }else{
            customSnackBar("Error","No data found in these dates");
            //customSnackBar("Success","No Data Found");
            isLoading.value = false;
          }
        }else{
          customSnackBar("Failed","Something went wronge");
          isLoading.value = false;
        }
      }else{
        customSnackBar("Network Error","No internet found");
        isLoading.value = false;
      }
     },
    );
  }

}