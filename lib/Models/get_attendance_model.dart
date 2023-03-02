// To parse this JSON data, do
//
//     final getAttendanceModel = getAttendanceModelFromJson(jsonString);

import 'dart:convert';

GetAttendanceModel getAttendanceModelFromJson(String str) => GetAttendanceModel.fromJson(json.decode(str));

String getAttendanceModelToJson(GetAttendanceModel data) => json.encode(data.toJson());

class GetAttendanceModel {
  GetAttendanceModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  List<String> message;
  dynamic data;

  factory GetAttendanceModel.fromJson(Map<String, dynamic> json) => GetAttendanceModel(
    status: json["status"],
    message: List<String>.from(json["message"].map((x) => x)),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": List<dynamic>.from(message.map((x) => x)),
    "data": data.toJson() ?? [],
  };
}

class Data {
  Data({
    required this.employeeNumber,
    required this.type,
    required this.intime,
    required this.outtime,
    required this.attendanceDate,
    required this.day,
    required this.workingHours,
  });

  int employeeNumber;
  String type;
  String intime;
  String outtime;
  DateTime attendanceDate;
  String day;
  String workingHours;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    employeeNumber: json["employee_number"],
    type: json["type"],
    intime: json["intime"],
    outtime: json["outtime"] ?? '',
    attendanceDate: DateTime.parse(json["attendance_date"]),
    day: json["day"] ?? '',
    workingHours: json["working_hours"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "employee_number": employeeNumber,
    "type": type,
    "intime": intime,
    "outtime": outtime,
    "attendance_date": "${attendanceDate.year.toString().padLeft(4, '0')}-${attendanceDate.month.toString().padLeft(2, '0')}-${attendanceDate.day.toString().padLeft(2, '0')}",
    "day": day,
    "working_hours": workingHours,
  };
}
