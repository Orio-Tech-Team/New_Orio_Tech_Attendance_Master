import 'dart:convert';

GetAttendanceData getAttendanceDataFromJson(String str) => GetAttendanceData.fromJson(json.decode(str));

String getAttendanceDataToJson(GetAttendanceData data) => json.encode(data.toJson());

class GetAttendanceData {
  GetAttendanceData({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  List<String> message;
  List<Datum> data;

  factory GetAttendanceData.fromJson(Map<String, dynamic> json) => GetAttendanceData(
    status: json["status"],
    message: List<String>.from(json["message"].map((x) => x)),
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": List<dynamic>.from(message.map((x) => x)),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.shiftId,
    required this.employeeNumber,
    required this.employeeName,
    required this.intime,
    required this.outtime,
    required this.type,
    required this.attendanceDate,
    required this.day,
    required this.workingHours,
    required this.shift,
  });

  int id;
  int shiftId;
  int employeeNumber;
  String employeeName;
  String intime;
  String outtime;
  String type;
  String attendanceDate;
  String day;
  String workingHours;
  Shift shift;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    shiftId: json["shift_id"],
    employeeNumber: json["employee_number"],
    employeeName: json["employee_name"],
    intime: json["intime"],
    outtime: json["outtime"],
    type: json["type"],
    attendanceDate: json["attendance_date"],
    day: json["day"],
    workingHours: json["working_hours"],
    shift: shiftValues.map[json["shift"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shift_id": shiftId,
    "employee_number": employeeNumber,
    "employee_name": employeeName,
    "intime": intime,
    "outtime": outtime,
    "type": type,
    "attendance_date": attendanceDate,
    "day": day,
    "working_hours": workingHours,
    "shift": shiftValues.reverse[shift],
  };
}

enum EmployeeName { MUBASHIR_ARIF }

final employeeNameValues = EnumValues({
  "Mubashir Arif": EmployeeName.MUBASHIR_ARIF
});

enum Shift { THE_100000180000 }

final shiftValues = EnumValues({
  "10:00:00 - 18:00:00": Shift.THE_100000180000
});

enum Type { PRESENT, LATE }

final typeValues = EnumValues({
  "Late": Type.LATE,
  "Present": Type.PRESENT
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
