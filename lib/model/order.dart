import 'package:productpayment/model/product.dart';

class Order {
  int _orderId;
  int _quntity;
  String _priceName;
  double _itemPrice;
  Product _product = new Product();
  String _creationDate;
  bool _deliverd;
  bool _price1;

  Order();

  int get orderId => _orderId;
  set orderId(int orderId) => _orderId = orderId;
  int get quntity => _quntity;
  set quntity(int quntity) => _quntity = quntity;
  String get priceName => _priceName;
  set priceName(String priceName) => _priceName = priceName;
  double get itemPrice => _itemPrice;
  set itemPrice(double itemPrice) => _itemPrice = itemPrice;
  Product get product => _product;
  set product(Product product) => _product = product;
  String get creationDate => _creationDate;
  set creationDate(String creationDate) => _creationDate = creationDate;
  bool get deliverd => _deliverd;
  set deliverd(bool deliverd) => _deliverd = deliverd;
  bool get price1 => _price1;
  set price1(bool price1) => _price1 = price1;

  Order.fromJson(Map<String, dynamic> json) {
    _orderId = json['orderId'];
    _quntity = json['quntity'];
    _priceName = json['priceName'];
    _itemPrice = json['itemPrice'];
    _product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    _creationDate = json['creationDate'];
    _deliverd = json['deliverd'];
    _price1 = json['price1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this._orderId;
    data['quntity'] = this._quntity;
    data['priceName'] = this._priceName;
    data['itemPrice'] = this._itemPrice;
    if (this._product != null) {
      data['product'] = this._product.toJson();
    }
    data['creationDate'] = this._creationDate;
    data['deliverd'] = this._deliverd;
    data['price1'] = this._price1;
    return data;
  }
}