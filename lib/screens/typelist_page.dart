import 'dart:convert';
import 'package:flutter/cupertino.dart' as wid;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:productpayment/model/general.dart';
import 'package:productpayment/model/pageList.dart';
import 'package:productpayment/model/product.dart';
import 'package:productpayment/screens/quantities_page.dart';

class TypeList extends StatefulWidget {
  final int type;

  TypeList({this.type});

  @override
  _TypeListState createState() => _TypeListState(type);
}

class _TypeListState extends State<TypeList> {
  final int type;
  _TypeListState(this.type);

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }
  List<Product> data =[];

  Future<PageList> getJsonData() async{
    var response=await http.get(
      Uri.encodeFull("$serverBaseUrl/product/getvaildfilterallproducts/"+type.toString()+""),
      headers: {"Accept":"application/json"}
    );
    print(response.body);
    setState(() {
      var convertDataToJson = pageListFromJson(response.body);
      data= convertDataToJson.content;

      print(data);
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: data.length==0? new Center(child: Text('No Data')):
    GridView.builder(
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
      itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Quantities(
                product: data[index],
              )));
            },
            child: Card(
              elevation: 10.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      height: 110.0,
                      width: 110.0,
                      color: Colors.grey,
                      child: data[index].image[0].url==null?Container():wid.Image.network(data[index].image[0].url),
                    ),
                  ),
                  Text(data[index].title,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          ),
        );
      },
),
    );
  }
}
