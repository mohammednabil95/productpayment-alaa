import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:productpayment/model/cart.dart';
import 'package:productpayment/model/general.dart';
import 'package:productpayment/model/type.dart';
import 'package:productpayment/screens/typelist_page.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<List<Type>> getJsonData() async {
    var response = await http.get(
        "$serverBaseUrl/product/getAllProudctType");
    var jsonData = json.decode(response.body);
    List<Type> types = [];
    for (var u in jsonData) {
      Type type = Type(u["productTypeId"], u["name"], u["image"], u["active"]);
      types.add(type);
    }
    print(types);
    return types;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return PlatformScaffold(
          body: Container(
            child: new Center(
              child: FutureBuilder(
                future: getJsonData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                        child: Center(child: CircularProgressIndicator()));
                  } else {
                    var kk = snapshot.data as List<Type>;
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                  bottom: 20.0,
                                  top: 30.0),
                              child: GestureDetector(
                                  onTap: () {
                              Navigator.push(context,
                                  new MaterialPageRoute(builder: (context) => TypeList(type: kk[index].productTypeId,))
                              );
                                  },
                                  child: Container(
                                    child: new FittedBox(
                                      child: Material(
                                          color: Colors.white,
                                          elevation: 15.0,
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          shadowColor: Color(0x802196F3),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                width: 280,
                                                height: 200,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          15.0),
                                                  child: Image.network(
                                                      kk[index].image),
                                                ),
                                              ),
                                              Text(
                                                kk[index].name,
                                                style: TextStyle(
                                                    color: Colors.blueGrey[700],
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0),
                                              ),
                                            ],
                                          )),
                                    ),
                                  )));
                        });
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
