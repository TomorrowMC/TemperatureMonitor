// To parse this JSON data, do
//
//     final car = carFromJson(jsonString);

import 'dart:convert';

List<Car> carFromJson(String str) => List<Car>.from(json.decode(str).map((x) => Car.fromJson(x)));

String carToJson(List<Car> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Car {
  Car({
    required this.deviceId,
    required this.latestHumidity,
    required this.parameterNames,
  });

  final int deviceId;
  final int latestHumidity;
  final List<String> parameterNames;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    deviceId: json["device_id"],
    latestHumidity: json["latest_humidity"],
    parameterNames: List<String>.from(json["parameter_names"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "device_id": deviceId,
    "latest_humidity": latestHumidity,
    "parameter_names": List<dynamic>.from(parameterNames.map((x) => x)),
  };
}
