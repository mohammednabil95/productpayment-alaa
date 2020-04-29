import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:productpayment/model/cart.dart';
import 'package:productpayment/screens/home_page.dart';
import 'package:productpayment/screens/login_page.dart';
import 'package:productpayment/screens/main_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(
    ChangeNotifierProvider(
      create: (context) => Cart(),
      child: MyApp(),
    )
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Payment',
      home: MainPage(),
//      Home()

    );
  }
}
