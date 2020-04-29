// To parse this JSON data, do
//
//     final userRegister = userRegisterFromJson(jsonString);

import 'dart:convert';

UserRegister userRegisterFromJson(String str) => UserRegister.fromJson(json.decode(str));

String userRegisterToJson(UserRegister data) => json.encode(data.toJson());

class UserRegister {
  User user;
  Driver driver;

  UserRegister({
    this.user,
    this.driver,
  });

  factory UserRegister.fromJson(Map<String, dynamic> json) => UserRegister(
    user: json['user'] != null ? new User.fromJson(json['user']) : null,
    driver: json['driver'] != null ? new Driver.fromJson(json['driver']) : null,
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "driver": driver.toJson(),
  };
}

class Driver {
  int driverId = 0;
  String deliveryCount ="";
  String totalMoney="";
  String totalMoneyWithdraw="";

  Driver({
    this.driverId,
    this.deliveryCount,
    this.totalMoney,
    this.totalMoneyWithdraw,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    driverId: json["driverId"],
    deliveryCount: json["deliveryCount"],
    totalMoney: json["totalMoney"],
    totalMoneyWithdraw: json["totalMoneyWithdraw"],
  );

  Map<String, dynamic> toJson() => {
    "driverId": driverId,
    "deliveryCount": deliveryCount,
    "totalMoney": totalMoney,
    "totalMoneyWithdraw": totalMoneyWithdraw,
  };
}

class User {
  int userId;
  String name;
  String mobile;
  String token;
  double lat;
  double lng;
  bool isDriver;
  bool admin;
  bool mobileVaild;
  bool isLock;
  bool isPanding;

  User({
    this.userId,
    this.name,
    this.mobile,
    this.token,
    this.lat,
    this.lng,
    this.isDriver,
    this.admin,
    this.mobileVaild,
    this.isLock,
    this.isPanding,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["userId"],
    name: json["name"],
    mobile: json["mobile"],
    token: json["token"],
    lat: json["lat"],
    lng: json["lng"],
    isDriver: json["isDriver"],
    admin: json["admin"],
    mobileVaild: json["mobileVaild"],
    isLock: json["isLock"],
    isPanding: json["isPanding"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "name": name,
    "mobile": mobile,
    "token": token,
    "lat": lat,
    "lng": lng,
    "isDriver": isDriver,
    "admin": admin,
    "mobileVaild": mobileVaild,
    "isLock": isLock,
    "isPanding": isPanding,
  };
}
