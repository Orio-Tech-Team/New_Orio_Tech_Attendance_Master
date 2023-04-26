// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../../Controller/Attendance Controller/attendance_controller.dart';
import '../../Shimmer/attendance_shimmer.dart';
import '../../Utils/Colors/color_resource.dart';
import '../../Utils/Constant/text_context.dart';
import '../../Utils/Dialoug Box/custom_dialoug_box.dart';
import 'Attendance Data Screen/attendance_data_screen.dart';
import 'package:connectivity_widget/connectivity_widget.dart';

AttendanceController attendanceController = Get.put(AttendanceController());

class AttendanceBodyScreen extends StatefulWidget {
  const AttendanceBodyScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceBodyScreen> createState() => _AttendanceBodyScreenState();
}

class _AttendanceBodyScreenState extends State<AttendanceBodyScreen> {
  @override
  Widget build(BuildContext context) {
    return ConnectivityWidget(
        showOfflineBanner: false,
        builder: (context, isOnline) {
          return isOnline
              ? Center(
                  child: Obx(
                    () => attendanceController.isLoading.value == false
                        ? Column(
                            children: [
                              Padding(
                                padding: kDefaultPadding,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                      onPressed: () {
                                        Get.toNamed(
                                            AttendanceDataScreen.routeName);
                                      },
                                      icon: SvgPicture.asset(
                                          'assets/icons/calender.svg')),
                                ),
                              ),
                              dateTimeShow(),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () async {
                                  if (isInRange.value == true) {
                                    var location = Location();
                                    bool enabled =
                                        await location.serviceEnabled();
                                    if (enabled == false) {
                                      isInRange.value = false;
                                      customSnackBar(
                                          "Location", "Your Location is off");
                                    } else {
                                      attendanceController.getAttendance();
                                    }
                                  }
                                },
                                child: Container(
                                  width: 172,
                                  height: 172,
                                  decoration: BoxDecoration(
                                    color: isInRange.value == true
                                        ? null
                                        : ColorResources.COLOR_GREY,
                                    gradient: isInRange.value == true
                                        ? attendanceController
                                                    .getAttendanceModel !=
                                                null
                                            ? attendanceController
                                                        .getAttendanceModel!
                                                        .data
                                                        .outtime !=
                                                    null
                                                ? ColorResources.kGradient
                                                : ColorResources.kGradient2
                                            : ColorResources.kGradient2
                                        : null,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      attendanceController.isLoading.value ==
                                              true
                                          ? const CircularProgressIndicator(
                                              color: Colors.white)
                                          : isInRange.value
                                              ? attendanceController
                                                          .getAttendanceModel !=
                                                      null
                                                  ? attendanceController
                                                              .getAttendanceModel!
                                                              .data
                                                              .outtime !=
                                                          null
                                                      ? SvgPicture.asset(
                                                          'assets/icons/checkout.svg',
                                                          color: Colors.white,
                                                          width: 70,
                                                          height: 70,
                                                        )
                                                      : SvgPicture.asset(
                                                          'assets/icons/attendance_click.svg',
                                                          color: Colors.white,
                                                          width: 70,
                                                          height: 70,
                                                        )
                                                  : SvgPicture.asset(
                                                      'assets/icons/attendance_click.svg',
                                                      color: Colors.white,
                                                      width: 70,
                                                      height: 70,
                                                    )
                                              : const Icon(
                                                  Icons.location_off_outlined,
                                                  color: Colors.white,
                                                  size: 70,
                                                ),
                                      const SizedBox(height: 10),
                                      Text(
                                        isInRange.value
                                            ? attendanceController
                                                        .getAttendanceModel !=
                                                    null
                                                ? attendanceController
                                                            .getAttendanceModel!
                                                            .data
                                                            .outtime !=
                                                        null
                                                    ? 'Check Out'
                                                    : 'Check In'
                                                : 'Check In'
                                            : 'Out of Range',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              inRangeText(isInRange.value),
                              const Expanded(child: SizedBox(height: 20)),
                              attendanceController.isLoading.value == false
                                  ? const AttendanceInfo()
                                  : const CircularProgressIndicator(
                                      color: kPrimaryColor,
                                    ),
                              const SizedBox(height: 70),
                            ],
                          )
                        : const AttendanceShimmer(),
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.wifi_off,
                        size: 120,
                        color: kPrimaryColor,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("No Internet Connection Found!"),
                    ],
                  ),
                );
        });
  }
}

Widget dateTimeShow() {
  return Column(
    children: [
      Text(
        attendanceController.dateNow,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 25.0,
        ),
      ),
      Text(
        '${kWeekDays[attendanceController.date.weekday - 1]}, ${kMonthNames[attendanceController.date.month - 1]} ${attendanceController.date.day}',
        style: const TextStyle(
          color: Color(0xFF6E6E6E),
        ),
      ),
    ],
  );
}

Widget attendanceButton(
  bool isLoading,
) {
  return GestureDetector(
    onTap: () async {
      if (isInRange.value == true) {
        var location = Location();
        bool enabled = await location.serviceEnabled();
        print('==============> LOCATION $enabled');
        if (enabled == false) {
          isInRange.value = false;
          customSnackBar("Location", "Location is off");
        } else {
          attendanceController.getAttendance();
        }
      }
    },
    child: Container(
      width: 172,
      height: 172,
      decoration: BoxDecoration(
        color: isInRange.value == true ? null : ColorResources.COLOR_GREY,
        gradient: isInRange == true
            ? attendanceController.getEmployeeAttendanceModel != null
                ? ColorResources.kGradient
                : ColorResources.kGradient2
            : null,
        shape: BoxShape.circle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isLoading == true
              ? const CircularProgressIndicator(color: Colors.white)
              : isInRange.value
                  ? attendanceController.getEmployeeAttendanceModel != null
                      ? SvgPicture.asset(
                          'assets/icons/attendance_click.svg',
                          color: Colors.white,
                          width: 70,
                          height: 70,
                        )
                      : SvgPicture.asset(
                          'assets/icons/checkout.svg',
                          color: Colors.white,
                          width: 70,
                          height: 70,
                        )
                  : const Icon(
                      Icons.location_off_outlined,
                      color: Colors.white,
                      size: 70,
                    ),
          const SizedBox(height: 10),
          Text(
            isInRange.value
                ? attendanceController.getEmployeeAttendanceModel == null
                    ? 'Check In'
                    : 'Check Out'
                : 'Out of Range',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    ),
  );
}

Widget inRangeText(bool isInRange) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset('assets/icons/map_pin.svg',
          color: isInRange ? kPrimaryColor : Colors.grey),
      const SizedBox(width: 5),
      Text(
        isInRange == true
            ? 'You are in the office range'
            : 'You are not in the office range',
        style: const TextStyle(
          color: Color(0xFF6E6E6E),
        ),
      ),
    ],
  );
}

class AttendanceInfo extends StatelessWidget {
  const AttendanceInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          checkItem(
            'assets/icons/check_in.svg',
            'Check In',
            attendanceController.getAttendanceModel != null
                ? attendanceController.getAttendanceModel!.data.intime
                    .substring(0, 5)
                : '--:--',
          ),
          checkItem(
            'assets/icons/check_out.svg',
            'Check Out',
            attendanceController.getAttendanceModel != null
                ? attendanceController.getAttendanceModel!.data.outtime != ""
                    ? attendanceController.getAttendanceModel!.data.outtime
                        .substring(0, 5)
                    : '--:--'
                : '--:--',
          ),
          checkItem(
            'assets/icons/hours.svg',
            'Working Hours',
            attendanceController.getAttendanceModel != null
                ? attendanceController.getAttendanceModel!.data.workingHours !=
                        ""
                    ? attendanceController.getAttendanceModel!.data.workingHours
                        .substring(0, 5)
                    : '--:--'
                : '--:--',
          ),
        ],
      ),
    );
  }
}

Widget checkItem(String icon, String text, String time) {
  return SizedBox(
    width: 90,
    child: Column(
      children: [
        SvgPicture.asset(icon),
        const SizedBox(height: 5),
        Text(
          time,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        Text(
          text,
          style: const TextStyle(color: Color(0xFF6E6E6E), fontSize: 10),
        ),
      ],
    ),
  );
}
