import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:productpayment/model/general.dart';
import 'package:productpayment/screens/otp_page.dart';
import 'package:http/http.dart' as http;
import 'package:productpayment/screens/register_page.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController mobileNumber=TextEditingController();

  Future<String> getOTP(var mobile) async{
    var response=await http.post(
        Uri.encodeFull("$serverBaseUrl/user/otp/"+ mobile.toString().trim()),
        headers: {"Accept":"application/json"}
    );
    if(response.statusCode >= 200 && response.statusCode < 300){
      final responseString=response.body;
      print(responseString);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OTP(value: mobile,)));
      return null;
    }else{
      final responseString=response.body;
      var result = json.decode(responseString);
      print("debug: " + result["message"]);
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40.0),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        style: new TextStyle(color: Colors.black),
                        validator: (val)=>val.length==0?"Enter Your Mobile Number":null,
                        controller: mobileNumber,
                        decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                          ),
                          hintText: "Mobile Number",
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: Center(
                        child: PlatformButton(
                          onPressed: () async {
                            if(_formKey.currentState.validate()){
                              getOTP(mobileNumber.text.toString().trim());
//                              final String mob=mobileNumber.text;
                            }
                          },
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                            androidFlat: (_) =>
                                MaterialFlatButtonData(color: Colors.cyan),
                            ios: (_) => CupertinoButtonData(color: Colors.cyan)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Register()));
                          },
                          child: Text(
                            'New User ? Register',
                            style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.greenAccent[700]),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
