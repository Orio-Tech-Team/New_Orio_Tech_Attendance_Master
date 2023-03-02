import 'package:flutter/material.dart';
import 'package:orio_tech_attendance_app/Utils/Colors/color_resource.dart';

class MyDropdown extends StatelessWidget {
  final List<String> items;
  final String? selected;
  final onChange;

  const MyDropdown({
    super.key,
    required this.items,
    required this.selected,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.transparent,
      ),
    );

    return DropdownButtonFormField(
      decoration: InputDecoration(
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        filled: true,
        fillColor: ColorResources.FIELD_COLOR,
      ),
      items: items
          .map(
            (item) => DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
            )),
      )
          .toList(),
      value: selected,
      onChanged: onChange,
      style: const TextStyle(
        color: Color(0xFF828282),
        fontSize: 16,
      ),
    );
  }
}
