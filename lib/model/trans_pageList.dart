import 'dart:convert';

import 'package:productpayment/model/product.dart';

import 'transacation.dart';
PageList pageListFromJson(String str) => PageList.fromJson(json.decode(str));

String pageListProductoJson(PageList data) => json.encode(data.toJson());
class PageList{
  List<Transaction> _content;
  bool _first;
  bool _last;
  int _number;
  int _numberOfElements;
  int _size;
  int _totalElements;
  int _totalPages;

  PageList();

  List<dynamic> get content => _content;
  set content(List<Transaction> content) => _content = content;
  bool get first => _first;
  set first(bool first) => _first = first;
  bool get last => _last;
  set last(bool last) => _last = last;
  int get number => _number;
  set number(int number) => _number = number;
  int get numberOfElements => _numberOfElements;
  set numberOfElements(int numberOfElements) =>
      _numberOfElements = numberOfElements;
  int get size => _size;
  set size(int size) => _size = size;
  int get totalElements => _totalElements;
  set totalElements(int totalElements) => _totalElements = totalElements;
  int get totalPages => _totalPages;
  set totalPages(int totalPages) => _totalPages = totalPages;

  PageList.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      _content = new List<Transaction>();
      json['content'].forEach((v) {
        _content.add(new Transaction.fromJson(v));
      });
    }
    _first = json['first'];
    _last = json['last'];
    _number = json['number'];
    _numberOfElements = json['numberOfElements'];
    _size = json['size'];
    _totalElements = json['totalElements'];
    _totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._content != null) {
      data['content'] = this._content.map((v) => v.toJson()).toList();
    }
    data['first'] = this._first;
    data['last'] = this._last;
    data['number'] = this._number;
    data['numberOfElements'] = this._numberOfElements;
    data['size'] = this._size;
    data['totalElements'] = this._totalElements;
    data['totalPages'] = this._totalPages;
    return data;
  }
}