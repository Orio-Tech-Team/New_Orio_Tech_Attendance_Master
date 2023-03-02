import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RequestAttendanceController extends GetxController{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();
  String type = 'CheckIn';
  TimeOfDay time = TimeOfDay.now();

  /*void _onSuccess() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color:
                  const Color.fromARGB(255, 216, 243, 209).withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 70,
                  color: Colors.green,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Request Send!',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 25.0,
                ),
              )
            ],
          ),
        ),
      ));*/

  void onSubmit() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      //_onSuccess();
    } else {
      print('error');
    }
  }
}