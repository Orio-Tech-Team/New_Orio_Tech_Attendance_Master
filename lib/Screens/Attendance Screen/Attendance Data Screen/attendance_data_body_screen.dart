import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orio_tech_attendance_app/Utils/Data%20Selector/data_selector.dart';
import 'package:orio_tech_attendance_app/Widgets/TextField/text_field_container.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../Controller/Attendance Controller/Attendance Data Controller/attendance_data_controller.dart';
import '../../../Utils/Colors/color_resource.dart';
import '../../../Utils/Constant/text_context.dart';
import '../../../Widgets/Button/button.dart';

AttendanceDataController attendanceDataController =
    Get.put(AttendanceDataController());

class AttendanceDataBodyScreen extends StatelessWidget {
  const AttendanceDataBodyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
            child: Row(
              children: const [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      'Attendance Data',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFieldContainer(
                width: Get.width * 0.35,
                child: DateSelector(
                    name: 'From Date',
                    date: attendanceDataController.fromDate,
                    onChange: (value) {
                      attendanceDataController.fromDate = DateTime.parse(value);
                    }),
              ),
              TextFieldContainer(
                width: Get.width * 0.35,
                child: DateSelector(
                    name: 'To Date',
                    date: attendanceDataController.toDate,
                    onChange: (value) {
                      attendanceDataController.toDate = DateTime.parse(value);
                    }),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          attendanceDataController.isLoading.value == false
              ? Button(
                  child: const Text('View', style: TextStyle(fontSize: 18)),
                  onPressed: () {
                    attendanceDataController.onSubmit();
                  },
                )
              : const CircularProgressIndicator(),
          const SizedBox(
            height: 20,
          ),
          attendanceDataController.isSuccess.value == true
              ? myTable()
              : const SizedBox(),
        ],
      ),
    );
  }
}

Widget monthListView() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: SizedBox(
      width: Get.size.width,
      height: 50,
      child: ScrollablePositionedList.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemScrollController: attendanceDataController.scrollController,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: kCompleteMonthNames[index] == ""
              ? Container(
                  decoration: BoxDecoration(
                    gradient: ColorResources.kGradient,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  width: 130,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                        ),
                        primary: Colors.transparent,
                      ),
                      child: Text(kCompleteMonthNames[index])),
                )
              : TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    primary: Colors.grey,
                    textStyle: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  child: Text(kCompleteMonthNames[index]),
                ),
        ),
        itemCount: 3,
      ),
    ),
  );
}

Widget myTable() {
  var length = attendanceDataController.getAttendanceData!.data.length;
  return Table(
    border: TableBorder.all(
      color: const Color(0xFFC4C4C4),
      width: 1,
    ),
    children: [
      TableRow(
        decoration: const BoxDecoration(
          color: Color(0xFFF7F7F7),
        ),
        children: [
          buildHeaderCell('Date'),
          buildHeaderCell('Check In'),
          buildHeaderCell('Check Out'),
          buildHeaderCell('Work Hr\'s'),
        ],
      ),
      for (int i = 0; i <= length; i++)
        if (i < length)
          buildTableRow(
            date: attendanceDataController
                .getAttendanceData!.data[i].attendanceDate,
            day: attendanceDataController.getAttendanceData!.data[i].day,
            checkin: attendanceDataController.getAttendanceData!.data[i].intime,
            checkout:
                attendanceDataController.getAttendanceData!.data[i].outtime,
            hours: attendanceDataController
                .getAttendanceData!.data[i].workingHours,
            type: attendanceDataController.getAttendanceData!.data[i].type,
          ),
    ],
  );
}

Padding buildHeaderCell(String text) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

TableRow buildTableRow({date, day, checkin, checkout, hours, type}) {
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Text(
                //date.substring(8, 10),
                date.substring(8, 10),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                day,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Center(
          child: checkin != null
              ? Text(
                  checkin,
                  style: TextStyle(
                      color: type == 'Late'
                          ? const Color(0xFFE9010A)
                          : const Color(0xFF0047BA)),
                )
              : const Text(''),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Center(
          child: checkout != null ? Text(checkout) : const Text('00:00:00'),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Center(
          child: hours != null ? Text(hours) : const Text('00:00:00'),
        ),
      ),
    ],
  );
}
