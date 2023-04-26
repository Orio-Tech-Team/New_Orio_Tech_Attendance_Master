import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/Desk Controller/Request Attendance Controller/request_attendance_controller.dart';
import '../../../Utils/DropDown/my_dropdown.dart';
import '../../../Utils/Time Selector/time_selector.dart';
import '../../../Widgets/Button/button.dart';
import '../../../Widgets/TextField/text_field_container.dart';

class RequestAttendanceBodyScreen extends StatelessWidget {
  const RequestAttendanceBodyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RequestAttendanceController requestAttendanceController =
        Get.put(RequestAttendanceController());
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: SizedBox(
            height: Get.size.height * 0.8,
            child: Center(
              child: Form(
                key: requestAttendanceController.formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'REQUEST ATTENDANCE',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 20),
                    TextFieldContainer(
                      child: MyDropdown(
                        items: const ['CheckIn', 'CheckOut'],
                        selected: requestAttendanceController.type,
                        onChange: (value) {
                          requestAttendanceController.type = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFieldContainer(
                      child: TimeSelector(
                        name: 'SELECT TIME',
                        onChange: (value) {
                          requestAttendanceController.time = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Button(
                      child: const Text('Send Request',
                          style: TextStyle(fontSize: 18)),
                      onPressed: () => requestAttendanceController.onSubmit(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
