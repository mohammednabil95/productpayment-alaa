import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:productpayment/model/general.dart';
import 'package:productpayment/model/user_register.dart';
import 'package:productpayment/screens/otp_page.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  static double _locationMessage1 = 0;
  static double _locationMessage2 = 0;
  String value;
  final TextEditingController nameController=TextEditingController();
  final TextEditingController mobileController=TextEditingController();

  void _getCurrentLocation() async{
    final position=await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    print(position);
    setState(() {
      _locationMessage1=position.latitude;
      _locationMessage2=position.longitude;
    });
//    print(_locationMessage);
  }

  GoogleMapController _controller;

  Position position;
  Widget _child;

  void _setStyle(GoogleMapController controller) async {
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    controller.setMapStyle(value);
  }

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId('home'),
          position: LatLng(position.latitude, position.longitude),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: 'Current Location'))
    ].toSet();
  }

//  void _getCurrentLocation() async {
//    Position res = await Geolocator().getCurrentPosition();
//    setState(() {
//      position = res;
//      _child = _mapWidget();
//    });
//  }

  Widget _mapWidget() {
    return GoogleMap(
      mapType: MapType.normal,
      markers: _createMarker(),
      initialCameraPosition: CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 15.0,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
        _setStyle(controller);
      },
    );
  }

  Future<UserRegister> createUser(String name,String mobile,double latitude,double longitude) async{
    final String apiUrl="$serverBaseUrl/user/register";
    var user = new User(name: name,mobile: mobile,lat: latitude,lng: longitude, isDriver: false);
    var driver = new Driver();
    var fullUser = new  UserRegister(user:user, driver: driver );
    var fullUserJson = fullUser.toJson();
//    debugPrint(fullUser.toString());
    final response=await http.post(apiUrl,body: json.encode(fullUserJson),headers: {"content-type" : "application/json",
      "Accept": "application/json",}
    );
    print(response);
    if(response.statusCode >= 200 && response.statusCode < 300){
      final responseString=response.body;
      print(responseString);
      getOTP(mobile.toString().trim());
      return userRegisterFromJson(responseString);
    }else{
      final responseString=response.body;
      print(responseString);
      return null;
    }
  }
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
      print(responseString);
      return null;
    }
  }

  UserRegister _userRegister;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        size: 40.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: new ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: nameController,
                                style: new TextStyle(color: Colors.black),
                                validator: (val)=>val.length==0?"Enter Your Name":null,
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
                                  hintText: "Name",
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                controller: mobileController,
                                onChanged: (text){
                                  value=text;
                                },
                                style: new TextStyle(color: Colors.black),
                                validator: (val)=>val.length==0?"Enter Your Mobile Number":null,
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
                              padding: const EdgeInsets.only(top: 20.0),
                              child: PlatformButton(
                                onPressed: () {
                                  _getCurrentLocation();
                                },
                                child: Text('Get Current Location',style: TextStyle(color: Colors.white),),
                                  androidFlat: (_) => MaterialFlatButtonData(
                                      color: Colors.cyan
                                  ),
                                  ios: (_) => CupertinoButtonData(
                                      color: Colors.cyan
                                  )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                _locationMessage1.toString(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                _locationMessage2.toString(),
                              ),
                            ),
//                            Padding(
//                              padding: const EdgeInsets.only(top: 20.0),
//                              child: Container(
//                                height: 300.0,
//                                child: _child,
//                              ),
//                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Center(
                                child: PlatformButton(
                                  onPressed: () async{
                                    if(_formKey.currentState.validate()){
                                      final String name=nameController.text;
                                      final String mobile=mobileController.text;
                                      final UserRegister userRegister=await createUser(name, mobile, _locationMessage1, _locationMessage2);
                                      setState(() {
                                        _userRegister=userRegister;
                                      });
                                    }
                                  },
                                  child: Text('Register',style: TextStyle(color: Colors.white),),
                                    androidFlat: (_) => MaterialFlatButtonData(
                                        color: Colors.cyan
                                    ),
                                    ios: (_) => CupertinoButtonData(
                                        color: Colors.cyan
                                    )
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
