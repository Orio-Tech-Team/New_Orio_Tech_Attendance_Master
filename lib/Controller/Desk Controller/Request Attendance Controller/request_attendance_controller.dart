import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RequestAttendanceController extends GetxController{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();
  String type = 'CheckIn';
  TimeOfDay time = TimeOfDay.now();

  void onSubmit() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
    } else {
      print('error');
    }
  }
}