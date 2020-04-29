import 'package:flutter/cupertino.dart' as wid;
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:productpayment/model/cart.dart';
import 'package:productpayment/model/cartmodel.dart';
import 'package:productpayment/model/order.dart';
import 'package:productpayment/model/product.dart';
import 'package:provider/provider.dart';

class Quantities extends StatefulWidget {
  Product product;
//  var productId;
//  var productprice1;
//  var productprice2;
//  String productimage;
//  final productname;
//  final productdescription;
//  final nameprice1;
//  final nameprice2;

  Quantities(
      {this.product});
//  Quantities(
//      {
//        this.productId,
//        this.productprice1,
//        this.productprice2,
//        this.productimage,
//        this.productname,
//        this.productdescription,
//        this.nameprice1,
//        this.nameprice2});

  @override
  _QuantitiesState createState() =>
//      _QuantitiesState(productId,productprice1, productprice2, productimage, productname,productdescription,nameprice1,nameprice2);
_QuantitiesState(product);
}

class _QuantitiesState extends State<Quantities> {
  Product product;
//  final productId;
//  var productimage;
//  var productname;
//  var productdescription;
//  var productprice1;
//  var productprice2;
//  var nameprice1;
//  var nameprice2;
//  var finalprice1;
//  var finalprice2;
  int counter = 1;
  String choice1="";
  String choice2="";
  int b=0;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  _QuantitiesState(this.product);
//  _QuantitiesState(this.productId,this.productprice1, this.productprice2, this.productimage,
//      this.productname,this.productdescription,this.nameprice1,this.nameprice2);

  void increment() {
    setState(() {
      counter++;
    });
  }

  void decrement() {
    setState(() {
      counter--;
    });
  }

  void f1(int a){
    setState(() {
      b=a;
    });
  }

  _showSnackBar() {
    final snackBar = new SnackBar(content: new Text('Successfully Added'));
    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

  _errorSnackBar() {
    final snackBar = new SnackBar(content: new Text('Please Select Any Price'));
    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

//  @override
//  void initState() {
//    super.initState();
//    finalprice1=productprice1;
//    finalprice2=productprice2;
//  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return Scaffold(
          key: _scaffoldkey,
          appBar: AppBar(
            backgroundColor: Colors.lightBlue[900],
            title: Text('Details'),
          ),
          body: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 90.0, right: 90.0),
                        child: Container(
                          height: 140.0,
                          child: GridTile(
                            child: Container(
                              color: Colors.grey[200],
                            child: wid.Image.network(product.image[0].url),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        product.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0,
                        color: Colors.redAccent),
                      ),
                      DataTable(
                        columns: [
                          DataColumn(label: Container()),
                          DataColumn(label: Text('Type',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                              fontSize: 18.0),)),
                          DataColumn(label: Text('Price',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                              fontSize: 18.0),)),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(
                                Radio(
                                  value: 2,
                                  groupValue: b,
                                  onChanged: (v){
                                    f1(v);
                                  },
                                )
                            ),
                            DataCell(Text(product.price1Name,style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),)),
                            DataCell(
                              Text(
                                product.price1.toString() + " SAR",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            )
                          ]),
                          DataRow(cells: [
                            DataCell(
                                Radio(
                                  value: 3,
                                  groupValue: b,
                                  onChanged: (v){
                                    f1(v);
                                  },
                                )
                            ),
                            DataCell(Text(product.price2Name,style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),)),
                            DataCell(
                              Text(
                                product.price2.toString() + " SAR",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            )
                          ]),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            PlatformButton(
                                onPressed: () {
                                  decrement();
                                  if (counter < 1) {
                                    counter = 1;
                                  }
                                },
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30.0),
                                ),
                                androidFlat: (_) =>
                                    MaterialFlatButtonData(color: Colors.cyan),
                                ios: (_) =>
                                    CupertinoButtonData(color: Colors.cyan)),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 20.0),
                              child: Text(
                                '$counter',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30.0),
                              ),
                            ),
                            PlatformButton(
                                onPressed: () {
                                  increment();
                                },
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30.0),
                                ),
                                androidFlat: (_) =>
                                    MaterialFlatButtonData(color: Colors.cyan),
                                ios: (_) =>
                                    CupertinoButtonData(color: Colors.cyan)),
                          ],
                        ),
                      ),
                      Container(
                        height: 180.0,
                        margin: const EdgeInsets.only(
                            top: 8.0, right: 8.0, left: 8.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: myBoxDecoration(),
                        child: Scrollbar(
                          child: ListView(
                            children: <Widget>[
                              Text(
                                product.description,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(choice1),
                      Text(choice2),
                      Center(
                        child: PlatformButton(
                            onPressed: () {
                              Order order = new Order();
                              order.quntity =counter;
                              order.product = product;


                              if(b==2){
                                order.itemPrice =product.price1;
                                order.price1 =true;
                                order.priceName =product.price1Name;
                                cart.add(order);
                                _showSnackBar();
                              }else if(b==3){
                                order.itemPrice =product.price2;
                                order.price1 =false;
                                order.priceName =product.price2Name;
                                cart.add(order);
                                _showSnackBar();
                              }else if(b==0){
                                _errorSnackBar();
                              }
                            },
                            child: Text(
                              'Add to Cart',
                              style: TextStyle(color: Colors.white),
                            ),
                            androidFlat: (_) =>
                                MaterialFlatButtonData(color: Colors.cyan),
                            ios: (_) =>
                                CupertinoButtonData(color: Colors.cyan)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(color: Colors.blue),
    );
  }
}
