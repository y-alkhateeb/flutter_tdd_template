// To parse this JSON data, do
//
//     final loginFailureModel = loginFailureModelFromMap(jsonString);

import 'dart:convert';

class LoginFailureModel {
  LoginFailureModel({
    this.accountId,
  });

  final String accountId;

  factory LoginFailureModel.fromJson(String str) => LoginFailureModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginFailureModel.fromMap(Map<String, dynamic> json) => LoginFailureModel(
    accountId: json["accountId"] == null ? null : json["accountId"],
  );

  Map<String, dynamic> toMap() => {
    "accountId": accountId == null ? null : accountId,
  };
}
