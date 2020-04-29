import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:productpayment/model/backend.dart';
import 'package:productpayment/model/general.dart';
import 'package:productpayment/model/user_login.dart';
import 'package:productpayment/model/user_register.dart';
import 'package:productpayment/screens/home_page.dart';
import 'package:productpayment/screens/main_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class OTP extends StatefulWidget {
  final value;

  OTP({this.value});
  @override
  _OTPState createState() => _OTPState(value);
}

class _OTPState extends State<OTP> {
  String value;
  var firebaseToken = "";
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  TextEditingController otpedit=TextEditingController();
  var login = new UserLogin();
  _OTPState(this.value);

  @override
  void initState() {
    super.initState();
    this.token();
  }

  void token(){
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) {
        print('on launch $message');
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    String clientToken = _firebaseMessaging.getToken().then((token) {
      firebaseToken = token.toString();
      print("Token Init: " + token.toString());
    }).toString();
    BackendService.postToken(clientToken.toString(), "url");
    @override
    Stream<String> fcmStream = _firebaseMessaging.onTokenRefresh;
    fcmStream.listen((token) {});
    fcmStream.toString();
  }

  Future<UserRegister> getLogin(UserLogin userLogin) async{
    final String apiUrl="$serverBaseUrl/user/login";
    var userLoginJson = userLogin.toJson();
    final response=await http.post(apiUrl,body: json.encode(userLoginJson),headers: {"content-type" : "application/json",
      "Accept": "application/json",}
    );
//    print(response);
    if(response.statusCode >= 200 && response.statusCode < 300){
      final responseString=response.body;
      print(responseString);
      var result = userRegisterFromJson(responseString);
      SharedPreferences prefs=await SharedPreferences.getInstance();
      prefs.setBool('isLogin', true);
      prefs.setInt('userId', result.user.userId);
      prefs.setString('name', result.user.name);
      prefs.setString('mobile', result.user.mobile);
      prefs.setDouble('lat', result.user.lat);
      prefs.setDouble('lng', result.user.lng);
      prefs.setString('token',  result.user.token);
      prefs.setBool('isDriver', result.user.isDriver);
      if(result.user.isDriver == true) {
        prefs.setInt('driverId', result.driver.driverId);
      }
      print("Saved values");
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MainPage()));
      /*  SharedPreferences
      * userid
      * isLogin = true; // profile & checkout
      * in logout -> isLogin = false;
      * name
      * mobile
      * isDriver
      * token
      *driverId
      * */
      return result;
    }else{
      final responseString=response.body;
      var result = json.decode(responseString);
      print(result);
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close,size: 40.0))
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: new ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 120.0),
                          child: Center(child: PlatformText(value,style: TextStyle(fontSize: 35.0,fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,letterSpacing: 9.0,),)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0,right: 25.0,top: 90.0),
                          child: Container(
                            child: Center(
                              child: PinInputTextField(
                                autoFocus: true,
                                controller: otpedit,
                                textInputAction: TextInputAction.done,
                                pinLength: 4,
                                onSubmit: (pin) {
                                  if (pin.length == 4) {
//                                    _onFormSubmitted();
                                  } else {
//                                    showToast("Invalid OTP", Colors.red);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 130.0),
                          child: Center(
                            child: PlatformButton(
                              onPressed: () async {
                                var appType = "";
                                var deviceId = "";
                                DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                                AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
                                var android=androidInfo.androidId.toString();
//                                IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//                                var ios=iosInfo.model.toString();
                                if(Platform.isAndroid){
                                  appType = "Android";
                                  setState(() {
                                    deviceId = android;
                                  });
                                }else if(Platform.isIOS){
                                    appType = "IOS";
//                                    setState(() {
//                                      deviceId = ios;
//                                    });
                                  }
                                var login = new UserLogin();
                                login.mobileOrEmail = value;
                                login.password = otpedit.text;
                                login.appType = appType;
                                login.deviceId = deviceId;
                                login.token = firebaseToken;
//                                print(login.toJson());
                                getLogin(login);

//                                Navigator.of(context).push(MaterialPageRoute(
//                                    builder: (context) => MainPage()));       should be after login is secc
                              },
                              child: Text('Send',style: TextStyle(color: Colors.white),),
                                androidFlat: (_) => MaterialFlatButtonData(
                                  color: Colors.cyan
                                ),
                                ios: (_) => CupertinoButtonData(
                                    color: Colors.cyan
                                )
                            ),
                          ),
                        ),
                        Center(
                          child: RaisedButton(
                            onPressed: () async {
                              SharedPreferences prefs=await SharedPreferences.getInstance();
                              String mobile=prefs.getString('mobile');
//                              String password=prefs.getString('password');  //never save pure password
                              String appType=prefs.getString('appType');
                              String deviceId=prefs.getString('deviceId');
                              print('my mobile no:$mobile');
//                              print('my password:$password');
                              print('my apptype:$appType');
                              print('my device id:$deviceId');
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
