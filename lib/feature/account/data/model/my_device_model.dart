import 'dart:convert';

class MyDeviceModel {
  MyDeviceModel({
    this.name,
    this.lastSeenDate,
    this.ipAddress,
    this.location,
  });

  final String name;
  final String lastSeenDate;
  final String ipAddress;
  final String location;

  factory MyDeviceModel.fromJson(String str) => MyDeviceModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MyDeviceModel.fromMap(Map<String, dynamic> json) => MyDeviceModel(
    name: json["name"] == null ? null : json["name"],
    lastSeenDate: json["lastSeenDate"] == null ? null : json["lastSeenDate"],
    ipAddress: json["ipAddress"] == null ? null : json["ipAddress"],
    location: json["location"] == null ? null : json["location"],
  );

  Map<String, dynamic> toMap() => {
    "name": name == null ? null : name,
    "lastSeenDate": lastSeenDate == null ? null : lastSeenDate,
    "ipAddress": ipAddress == null ? null : ipAddress,
    "location": location == null ? null : location,
  };
}
