// To parse this JSON data, do
//
//     final userLogin = userLoginFromJson(jsonString);

import 'dart:convert';

import 'enum.dart';

//UserLogin userLoginFromJson(String str) => UserLogin.fromJson(json.decode(str));

String userLoginToJson(UserLogin data) => json.encode(data.toJson());

class UserLogin {

  String _appType;
  String _deviceId;
  String _mobileOrEmail;
  String _password;
  String _token;


  String get appType => _appType;

  set appType(String value) {
    _appType = value;
  }

  UserLogin();


//  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
//    appType: json["appType"],
//    deviceId: json["deviceId"],
//    mobileOrEmail: json["mobileOrEmail"],
//    password: json["password"],
//    token: json["token"],
//  );

  Map<String, dynamic> toJson() => {
    "appType": appType,
    "deviceId": deviceId,
    "mobileOrEmail": mobileOrEmail,
    "password": password,
    "token": token,
  };

  String get deviceId => _deviceId;

  set deviceId(String value) {
    _deviceId = value;
  }

  String get mobileOrEmail => _mobileOrEmail;

  set mobileOrEmail(String value) {
    _mobileOrEmail = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get token => _token;

  set token(String value) {
    _token = value;
  }
}
