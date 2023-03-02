import 'package:flutter/material.dart';
import 'package:orio_tech_attendance_app/Utils/Colors/color_resource.dart';

class TimeSelector extends StatefulWidget {
  final String name;
  final ValueChanged<TimeOfDay> onChange;

  TimeSelector({
    super.key,
    required this.name,
    required this.onChange,
  });

  @override
  State<TimeSelector> createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 5),
          InkWell(
            onTap: () async {
              TimeOfDay? newTime = await showTimePicker(
                context: context,
                initialTime: selectedTime,
              );

              if (newTime != null) {
                setState(() {
                  selectedTime = newTime;
                });

                widget.onChange(newTime);
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
                      '${selectedTime.hour}:${selectedTime.minute}',
                      style: const TextStyle(
                          color: Color(0xFF828282), fontSize: 20),
                    ),
                    const Icon(
                      Icons.access_time,
                      color: Color(0xFF828282),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
