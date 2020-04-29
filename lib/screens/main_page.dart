import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:productpayment/screens/about_page.dart';
import 'package:productpayment/screens/cart_page.dart';
import 'package:productpayment/screens/home_page.dart';
import 'package:productpayment/screens/notifications_page.dart';
import 'package:productpayment/screens/profile_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with AutomaticKeepAliveClientMixin{
  int _currentIndex=0;
  final tabs=[
    Profile(),
    AboutUs(),
    Home(),
    Notifications(),
    CartPage(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex=2;
  }
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: tabs[_currentIndex],
      bottomNavBar: PlatformNavBar(
        android: (_) => MaterialNavBarData(
          type: BottomNavigationBarType.fixed,
        ),
        ios: (_) => CupertinoTabBarData(
        ),
        currentIndex: _currentIndex,
        itemChanged: (index) => setState(() {
                _currentIndex = index;
          },
        ),
        items: [
          BottomNavigationBarItem(
            icon: PlatformWidget(
              ios: (_) => Icon(CupertinoIcons.person),
              android: (_) => Icon(Icons.person),
            ),
            title: Text('Profile'),
          ),
          BottomNavigationBarItem(
            icon: PlatformWidget(
              ios: (_) => Icon(CupertinoIcons.info),
              android: (_) => Icon(Icons.info),
            ),
            title: Text('About Us'),
          ),
          BottomNavigationBarItem(
            icon: PlatformWidget(
              ios: (_) => Icon(CupertinoIcons.home),
              android: (_) => Icon(Icons.home),
            ),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: PlatformWidget(
              ios: (_) => new Image.asset("assets/notification.png",height: 21.0,color: Colors.grey[600],),
              android: (_) => Icon(Icons.notifications),
            ),
            title: Text('Notifications',style: TextStyle(fontSize: 12.0),),
          ),
          BottomNavigationBarItem(
            icon: PlatformWidget(
              ios: (_) => Icon(CupertinoIcons.shopping_cart),
              android: (_) => Icon(Icons.shopping_cart),
            ),
            title: Text('Cart'),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
