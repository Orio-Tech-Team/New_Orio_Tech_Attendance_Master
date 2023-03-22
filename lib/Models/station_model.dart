import 'dart:convert';

StationModel stationModelFromJson(String str) => StationModel.fromJson(json.decode(str));
String stationModelToJson(StationModel data) => json.encode(data.toJson());

class StationModel {
  StationModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  List<String> message;
  List<Datum> data;

  factory StationModel.fromJson(Map<String, dynamic> json) => StationModel(
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
    this.createdAt,
    this.updatedAt,
    required this.employeeNumber,
    required this.employeeName,
    required this.employeeStation,
  });

  int id;
  dynamic createdAt;
  dynamic updatedAt;
  int employeeNumber;
  String employeeName;
  List<EmployeeStation> employeeStation;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    employeeNumber: json["employee_number"],
    employeeName: json["employee_name"],
    employeeStation: List<EmployeeStation>.from(json["employee_station"].map((x) => EmployeeStation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "employee_number": employeeNumber,
    "employee_name": employeeName,
    "employee_station": List<dynamic>.from(employeeStation.map((x) => x.toJson())),
  };
}

class EmployeeStation {
  EmployeeStation({
    required this.id,
    this.createdAt,
    this.updatedAt,
    required this.employeeNumber,
    required this.stationCode,
    required this.station,
  });

  int id;
  dynamic createdAt;
  dynamic updatedAt;
  int employeeNumber;
  String stationCode;
  Station station;

  factory EmployeeStation.fromJson(Map<String, dynamic> json) => EmployeeStation(
    id: json["id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    employeeNumber: json["employee_number"],
    stationCode: json["station_code"],
    station: Station.fromJson(json["station"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "employee_number": employeeNumber,
    "station_code": stationCode,
    "station": station.toJson(),
  };
}

class Station {
  Station({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.stationCode,
    required this.stationName,
    required this.latitude,
    required this.longtitude,
    required this.radius,
    required this.cityCode,
  });

  int id;
  String createdAt;
  String updatedAt;
  String stationCode;
  String stationName;
  String latitude;
  String longtitude;
  int radius;
  String cityCode;

  factory Station.fromJson(Map<String, dynamic> json) => Station(
    id: json["id"],
    createdAt: json["created_at"]??"",
    updatedAt: json["updated_at"]??"",
    stationCode: json["station_code"],
    stationName: json["station_name"],
    latitude: json["latitude"],
    longtitude: json["longtitude"],
    radius: json["radius"],
    cityCode: json["city_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "station_code": stationCode,
    "station_name": stationName,
    "latitude": latitude,
    "longtitude": longtitude,
    "radius": radius,
    "city_code": cityCode,
  };
}
