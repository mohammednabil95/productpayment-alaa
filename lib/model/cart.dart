import 'package:flutter/material.dart';
import 'package:productpayment/model/cartmodel.dart';
import 'package:productpayment/model/order.dart';
import 'package:productpayment/model/transacation.dart';

class Cart extends ChangeNotifier {
  Transaction _transaction = Transaction();
  double _totalPrice = 0.0;

  void add(Order item) {
    _transaction.order.add(item);
    _totalPrice += item.itemPrice;
    notifyListeners();
  }

  void remove(Order item) {
    _totalPrice -= item.itemPrice;
    _transaction.order.remove(item);
    notifyListeners();
  }

  int get count {
    return _transaction.order.length;
  }

  double get totalPrice {
    return _totalPrice;
  }

  List<Order> get basketItems {
    return _transaction.order;
  }
}