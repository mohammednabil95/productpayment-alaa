import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: PlatformAppBar(
          backgroundColor: Colors.lightBlue[900],
          automaticallyImplyLeading: false,
          title: Text('About Us'),
        ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0,left: 15.0),
            child: Text("fngksfjngsrnblnslnbln\nfngfngjnsfnglnsfgnsjlfnglonsln\nhgihrsihgivhsfihgvrh"
                "\nfgnofsngonsfongvolfnlnglofm\nhgisingiikhnfshngihfhngvkifnis",style: TextStyle(fontSize: 20.0,
            color: Colors.brown[600]),),
          ),
        ],
      )
    );
  }
}
