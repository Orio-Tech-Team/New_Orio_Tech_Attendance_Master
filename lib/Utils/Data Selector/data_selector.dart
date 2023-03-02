import 'package:flutter/material.dart';
import 'package:orio_tech_attendance_app/Utils/Colors/color_resource.dart';

import '../../Screens/Attendance Screen/Attendance Data Screen/attendance_data_body_screen.dart';

class DateSelector extends StatefulWidget {
  final String name;
  DateTime date;
  var onChange;

  DateSelector({
    super.key,
    required this.date,
    required this.name,
    required this.onChange,
  });

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 5),
          InkWell(
              onTap: () async {
                DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: widget.date,
                  firstDate: DateTime(2022),
                  lastDate: DateTime.now(),
                );
                if(widget.name == "From Date"){
                  attendanceDataController.fromDate = newDate!;
                }else{
                  attendanceDataController.toDate = newDate!;
                }

                print("NewData =====> $newDate");
                if (newDate != null) {
                  setState(() {
                    widget.date = newDate;
                    widget.onChange = newDate;
                  });

                }
              },
              child: Container(
                height: 52,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorResources.FIELD_COLOR,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.date.year}-${widget.date.month}-${widget.date.day}',
                        style: const TextStyle(
                            color: Color(0xFF828282), fontSize: 16),
                      ),
                      const Icon(
                        Icons.calendar_today_outlined,
                        color: Color(0xFF828282),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
