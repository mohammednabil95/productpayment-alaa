import 'package:productpayment/model/product2.dart';

class Product {
  int _productId;
  String _title;
  int _amount;
  double _price1;
  double _price2;
  String _price1Name;
  String _price2Name;
  String _description;
  bool _isFeature;
  ProductType _productType = new ProductType();
  List<Image> _image = [];

  Product();

  int get productId => _productId;
  set productId(int productId) => _productId = productId;
  String get title => _title;
  set title(String title) => _title = title;
  int get amount => _amount;
  set amount(int amount) => _amount = amount;
  double get price1 => _price1;
  set price1(double price1) => _price1 = price1;
  double get price2 => _price2;
  set price2(double price2) => _price2 = price2;
  String get price1Name => _price1Name;
  set price1Name(String price1Name) => _price1Name = price1Name;
  String get price2Name => _price2Name;
  set price2Name(String price2Name) => _price2Name = price2Name;
  String get description => _description;
  set description(String description) => _description = description;
  bool get isFeature => _isFeature;
  set isFeature(bool isFeature) => _isFeature = isFeature;
  ProductType get productType => _productType;
  set productType(ProductType productType) => _productType = productType;
  List<Image> get image => _image;
  set image(List<Image> image) => _image = image;

  Product.fromJson(Map<String, dynamic> json) {
    _productId = json['productId'];
    _title = json['title'];
    _amount = json['amount'];
    _price1 = json['price1'];
    _price2 = json['price2'];
    _price1Name = json['price1Name'];
    _price2Name = json['price2Name'];
    _description = json['description'];
    _isFeature = json['isFeature'];
    _productType = json['productType'] != null
        ? new ProductType.fromJson(json['productType'])
        : null;
    if (json['image'] != null) {
      _image = new List<Image>();
      json['image'].forEach((v) {
        _image.add(new Image.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this._productId;
    data['title'] = this._title;
    data['amount'] = this._amount;
    data['price1'] = this._price1;
    data['price2'] = this._price2;
    data['price1Name'] = this._price1Name;
    data['price2Name'] = this._price2Name;
    data['description'] = this._description;
    data['isFeature'] = this._isFeature;
    if (this._productType != null) {
      data['productType'] = this._productType.toJson();
    }
    if (this._image != null) {
      data['image'] = this._image.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Image {
  int _imageId;
  String _url;
  String _creationDate;

  Image({int imageId, String url, String creationDate}) {
    this._imageId = imageId;
    this._url = url;
    this._creationDate = creationDate;
  }

  int get imageId => _imageId;
  set imageId(int imageId) => _imageId = imageId;
  String get url => _url;
  set url(String url) => _url = url;
  String get creationDate => _creationDate;
  set creationDate(String creationDate) => _creationDate = creationDate;

  Image.fromJson(Map<String, dynamic> json) {
    _imageId = json['imageId'];
    _url = json['url'];
    _creationDate = json['creationDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageId'] = this._imageId;
    data['url'] = this._url;
    data['creationDate'] = this._creationDate;
    return data;
  }
}
