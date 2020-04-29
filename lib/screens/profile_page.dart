import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:productpayment/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'editprofile_page.dart';
import 'package:productpayment/screens/ViewPurchase_page.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var isLog = false;
  Future<bool> isLogin()  async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    isLog = prefs.getBool("isLogin");
    return isLog;
  }
  void reoud(){
      if(isLog == true ){
        print("login ");
      }else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Login()));
      }
  }

  @override
  void initState() {
    super.initState();
    isLogin().then((value) => reoud());

  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: PlatformAppBar(
          backgroundColor: Colors.lightBlue[900],
          automaticallyImplyLeading: false,
          title: Text('Profile'),
        ),
      body: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: (){
              print('tapped');
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditProfile()));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0,bottom: 8.0),
              child: Center(child: PlatformText('Edit Profile',style: TextStyle(fontSize: 20.0),)),
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          GestureDetector(
            onTap: (){
              print('tapped');
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
              child: Center(child: PlatformText('View Payment History',style: TextStyle(fontSize: 20.0),)),
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ViewPurchase()));
              print('tapped');
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
              child: Center(child: PlatformText('View Purchase',style: TextStyle(fontSize: 20.0),)),
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          GestureDetector(
            onTap: () async {
              SharedPreferences prefs= await SharedPreferences.getInstance();
              prefs.clear();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Login()));
              print('tapped');
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
              child: Center(child: PlatformText('Log out',style: TextStyle(fontSize: 20.0),)),
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Center(child: Text('Complaint',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.0,
              decoration: TextDecoration.underline,),)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 25.0),
            child: PlatformTextField(
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              style: new TextStyle(color: Colors.black),
              android: (_) => MaterialTextFieldData(
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
                  )),
              ios: (_) => CupertinoTextFieldData(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Center(
              child: PlatformButton(
                  child: Text('Send Complaint',style: TextStyle(color: Colors.white),),
                  onPressed: (){

                  },
                  androidFlat: (_) => MaterialFlatButtonData(
                      color: Colors.cyan
                  ),
                  ios: (_) => CupertinoButtonData(
                      color: Colors.cyan
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}