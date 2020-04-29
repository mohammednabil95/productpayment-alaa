import 'package:flutter/material.dart';

import '../model/transacation.dart';

class ViewOrder extends StatefulWidget {
  String transaction;

  ViewOrder({this.transaction});

  @override
  _ViewOrderState createState() => _ViewOrderState(transaction);
}

class _ViewOrderState extends State<ViewOrder> {
  String transaction;

  _ViewOrderState(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View Order'),),
      body: Container(),
    );
  }
}
