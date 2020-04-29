import 'package:productpayment/model/trans_pageList.dart';
import 'package:productpayment/screens/vieworder_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/general.dart';
import '../model/transacation.dart';

class ViewPurchase extends StatefulWidget {
  @override
  _ViewPurchaseState createState() => _ViewPurchaseState();
}

class _ViewPurchaseState extends State<ViewPurchase> {
  List<Transaction> data=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getJson();
  }

  Future<PageList> getJson() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var userId = prefs.getInt('userId').toString();
    var response=await http.get(
        Uri.encodeFull("$serverBaseUrl/order/getTransByUser/$userId"),
        headers: {"Accept":"application/json"}
    );
    print(response.body);
    setState(() {
      var convertDataToJson=pageListFromJson(response.body);
      data=convertDataToJson.content;
      print(data);
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View Purchase'),),
      body: data.length==0?Center(child: CircularProgressIndicator()):
          GridView.builder(
            itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewOrder(transaction: data[index].invoiceNumber.toString(),)));
                  },
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Text(data[index].order[0].orderId.toString()), // order id
                        Text(data[index].orderTime.toString()),  //order time
                        Text(data[index].orderDate.toString()), //date
                        Text(data[index].orderStatus.toString()), //status
                        Text(data[index].total.toString()),//total
                      ],
                    ),
                  ),
                ),
              );
              })
    );
  }
}
