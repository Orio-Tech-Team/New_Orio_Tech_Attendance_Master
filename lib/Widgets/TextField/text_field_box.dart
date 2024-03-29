import 'package:flutter/material.dart';
import 'package:orio_tech_attendance_app/Widgets/TextField/my_text_field.dart';
import 'package:orio_tech_attendance_app/Widgets/TextField/text_field_container.dart';

class TextFieldBox extends StatelessWidget {
  final bool autofocus;
  final Function onChange;
  final TextEditingController? controller;

  const TextFieldBox({
    super.key,
    this.autofocus = false,
    required this.onChange,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      width: 55,
      child: MyTextField(
        controller: controller,
        hintText: '',
        autofocus: autofocus,
        length: 1,
        onChange: onChange,
        required: false,
        textCenter: true,
        keyboardType: TextInputType.number,
      ),
    );
  }
}
