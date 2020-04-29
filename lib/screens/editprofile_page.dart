import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  TextEditingController textEditingController1=TextEditingController();
  TextEditingController textEditingController2=TextEditingController();
  static double _locationMessage1 =0;
  static double _locationMessage2 =0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  _showSnackBar() {
    final snackBar = new SnackBar(content: new Text('Successfully Changed'));
    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

  getUser() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
      textEditingController1.text=prefs.getString('name').toString();
      textEditingController2.text=prefs.getString('mobile').toString();
  }

  void _getCurrentLocation() async{
    final position=await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    print(position);
    setState(() {
      _locationMessage1=position.latitude;
      _locationMessage2=position.longitude;
    });
//    print(_locationMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(title: Text('Edit Profile'),),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textEditingController1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textEditingController2,
            ),
          ),
          Center(
            child: RaisedButton(
              onPressed: (){
                _getCurrentLocation();
              },
              child: Text('Get Current Location'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0,left: 10.0),
            child: Text(
              _locationMessage1.toString(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0,left: 10.0),
            child: Text(
              _locationMessage2.toString(),
            ),
          ),
          Center(
            child: RaisedButton(
              onPressed: () async {
                SharedPreferences prefs=await SharedPreferences.getInstance();
                prefs.setString('name', textEditingController1.toString());
                prefs.setString('mobile', textEditingController2.toString());
                prefs.setDouble('lat', _locationMessage1);
                prefs.setDouble('long', _locationMessage2);
                _showSnackBar();
              },
              child: Text('Save'),
            ),
          )
        ],
      ),
    );
  }
}
