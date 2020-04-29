import 'package:productpayment/model/user_register.dart';

import 'order.dart';

class Transaction {
  String _invoiceNumber;
  Null _onlineInvoice;
  int _driverId;
  int _total;
  String _orderStatus;
  List<Order> _order = [];
  User _user;
  String _orderDate;
  String _orderTime;
  bool _deliverd;

  Transaction();

  String get invoiceNumber => _invoiceNumber;
  set invoiceNumber(String invoiceNumber) => _invoiceNumber = invoiceNumber;
  Null get onlineInvoice => _onlineInvoice;
  set onlineInvoice(Null onlineInvoice) => _onlineInvoice = onlineInvoice;
  int get driverId => _driverId;
  set driverId(int driverId) => _driverId = driverId;
  int get total => _total;
  set total(int total) => _total = total;
  String get orderStatus => _orderStatus;
  set orderStatus(String orderStatus) => _orderStatus = orderStatus;
  List<Order> get order => _order;
  set order(List<Order> order) => _order = order;
  User get user => _user;
  set user(User user) => _user = user;
  String get orderDate => _orderDate;
  set orderDate(String orderDate) => _orderDate = orderDate;
  String get orderTime => _orderTime;
  set orderTime(String orderTime) => _orderTime = orderTime;
  bool get deliverd => _deliverd;
  set deliverd(bool deliverd) => _deliverd = deliverd;

  Transaction.fromJson(Map<String, dynamic> json) {
    _invoiceNumber = json['invoiceNumber'];
    _onlineInvoice = json['onlineInvoice'];
    _driverId = json['driverId'];
    _total = json['total'];
    _orderStatus = json['orderStatus'];
    if (json['order'] != null) {
      _order = new List<Order>();
      json['order'].forEach((v) {
        _order.add(new Order.fromJson(v));
      });
    }
    _user = json['user'] != null ? new User.fromJson(json['user']) : null;
    _orderDate = json['orderDate'];
    _orderTime = json['orderTime'];
    _deliverd = json['deliverd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoiceNumber'] = this._invoiceNumber;
    data['onlineInvoice'] = this._onlineInvoice;
    data['driverId'] = this._driverId;
    data['total'] = this._total;
    data['orderStatus'] = this._orderStatus;
    if (this._order != null) {
      data['order'] = this._order.map((v) => v.toJson()).toList();
    }
    if (this._user != null) {
      data['user'] = this._user.toJson();
    }
    data['orderDate'] = this._orderDate;
    data['orderTime'] = this._orderTime;
    data['deliverd'] = this._deliverd;
    return data;
  }
}