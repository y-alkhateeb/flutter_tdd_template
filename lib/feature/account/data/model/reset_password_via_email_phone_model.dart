import 'dart:convert';

class ResetPasswordViaEmailPhoneModel {
  ResetPasswordViaEmailPhoneModel({
    this.data,
    this.message,
  });

  final DataResponseModel data;
  final String message;

  factory ResetPasswordViaEmailPhoneModel.fromJson(String str) => ResetPasswordViaEmailPhoneModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResetPasswordViaEmailPhoneModel.fromMap(Map<String, dynamic> json) => ResetPasswordViaEmailPhoneModel(
    data: json["data"] == null ? null : DataResponseModel.fromMap(json["data"]),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : data.toMap(),
    "message": message == null ? null : message,
  };
}

class DataResponseModel {
  DataResponseModel({
    this.accountId,
  });

  final String accountId;

  factory DataResponseModel.fromJson(String str) => DataResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataResponseModel.fromMap(Map<String, dynamic> json) => DataResponseModel(
    accountId: json["accountId"] == null ? null : json["accountId"],
  );

  Map<String, dynamic> toMap() => {
    "accountId": accountId == null ? null : accountId,
  };
}
