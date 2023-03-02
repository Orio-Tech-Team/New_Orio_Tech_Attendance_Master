import 'dart:convert';

GetEmployeeAttendanceModel getEmployeeAttendanceModelFromJson(String str) => GetEmployeeAttendanceModel.fromJson(json.decode(str));

String getEmployeeAttendanceModelToJson(GetEmployeeAttendanceModel data) => json.encode(data.toJson());

class GetEmployeeAttendanceModel {
  GetEmployeeAttendanceModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  List<String> message;
  Data data;

  factory GetEmployeeAttendanceModel.fromJson(Map<String, dynamic> json) => GetEmployeeAttendanceModel(
    status: json["status"],
    message: List<String>.from(json["message"].map((x) => x)),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": List<dynamic>.from(message.map((x) => x)),
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.employeeNumber,
    required this.intime,
    required this.outtime,
    required this.attendanceDate,
    required this.type,
    required this.workingHours,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  int employeeNumber;
  String intime;
  String outtime;
  DateTime attendanceDate;
  String type;
  String workingHours;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] ?? '',
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    employeeNumber: json["employee_number"],
    intime: json["intime"],
    outtime: json["outtime"],
    attendanceDate: DateTime.parse(json["attendance_date"]),
    type: json["type"],
    workingHours: json["working_hours"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "employee_number": employeeNumber,
    "intime": intime,
    "outtime": outtime,
    "attendance_date": "${attendanceDate.year.toString().padLeft(4, '0')}-${attendanceDate.month.toString().padLeft(2, '0')}-${attendanceDate.day.toString().padLeft(2, '0')}",
    "type": type,
    "working_hours": workingHours,
  };
}
