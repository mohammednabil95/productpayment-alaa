// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product2 productFromJson(String str) => Product2.fromJson(json.decode(str));

String productToJson(Product2 data) => json.encode(data.toJson());

class Product2 {
  List<Content> content;
  bool last;
  int totalPages;
  int totalElements;
  int numberOfElements;
  bool first;
  dynamic sort;
  int size;
  int number;

  Product2({
    this.content,
    this.last,
    this.totalPages,
    this.totalElements,
    this.numberOfElements,
    this.first,
    this.sort,
    this.size,
    this.number,
  });

  factory Product2.fromJson(Map<String, dynamic> json) => Product2(
    content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
    last: json["last"],
    totalPages: json["totalPages"],
    totalElements: json["totalElements"],
    numberOfElements: json["numberOfElements"],
    first: json["first"],
    sort: json["sort"],
    size: json["size"],
    number: json["number"],
  );

  Map<String, dynamic> toJson() => {
    "content": List<dynamic>.from(content.map((x) => x.toJson())),
    "last": last,
    "totalPages": totalPages,
    "totalElements": totalElements,
    "numberOfElements": numberOfElements,
    "first": first,
    "sort": sort,
    "size": size,
    "number": number,
  };
}

class Content {
  int productId;
  String title;
  int amount;
  int price1;
  int price2;
  String price1Name;
  String price2Name;
  String description;
  bool isFeature;
  ProductType productType;
  bool vaild;
  bool isDelete;
  List<dynamic> image;
  DateTime creationdate;
  DateTime updateDate;

  Content({
    this.productId,
    this.title,
    this.amount,
    this.price1,
    this.price2,
    this.price1Name,
    this.price2Name,
    this.description,
    this.isFeature,
    this.productType,
    this.vaild,
    this.isDelete,
    this.image,
    this.creationdate,
    this.updateDate,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    productId: json["productId"],
    title: json["title"],
    amount: json["amount"],
    price1: json["price1"],
    price2: json["price2"],
    price1Name: json["price1Name"],
    price2Name: json["price2Name"],
    description: json["description"],
    isFeature: json["isFeature"],
    productType: ProductType.fromJson(json["productType"]),
    vaild: json["vaild"],
    isDelete: json["isDelete"],
    image: List<dynamic>.from(json["image"].map((x) => x)),
    creationdate: DateTime.parse(json["creationdate"]),
    updateDate: DateTime.parse(json["updateDate"]),
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "title": title,
    "amount": amount,
    "price1": price1,
    "price2": price2,
    "price1Name": price1Name,
    "price2Name": price2Name,
    "description": description,
    "isFeature": isFeature,
    "productType": productType.toJson(),
    "vaild": vaild,
    "isDelete": isDelete,
    "image": List<dynamic>.from(image.map((x) => x)),
    "creationdate": "${creationdate.year.toString().padLeft(4, '0')}-${creationdate.month.toString().padLeft(2, '0')}-${creationdate.day.toString().padLeft(2, '0')}",
    "updateDate": "${updateDate.year.toString().padLeft(4, '0')}-${updateDate.month.toString().padLeft(2, '0')}-${updateDate.day.toString().padLeft(2, '0')}",
  };
}

class ProductType {
  int productTypeId;
  String name;
  String image;
  bool active;

  ProductType({
    this.productTypeId,
    this.name,
    this.image,
    this.active,
  });

  factory ProductType.fromJson(Map<String, dynamic> json) => ProductType(
    productTypeId: json["productTypeId"],
    name: json["name"],
    image: json["image"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "productTypeId": productTypeId,
    "name": name,
    "image": image,
    "active": active,
  };
}
