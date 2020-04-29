import 'package:flutter/cupertino.dart' as wid;
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:productpayment/model/cart.dart';
import 'package:productpayment/model/cartmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart' as gateway;
import 'login_page.dart';

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage> {
  var total = "0";
  // Base Url
  final String baseUrlDemo = "https://apitest.myfatoorah.com";

// Token for regular payment
  final String regularPaymentTokenDemo =
      "7Fs7eBv21F5xAocdPvvJ-sCqEyNHq4cygJrQUFvFiWEexBUPs4AkeLQxH4pzsUrY3Rays7GVA6SojFCz2DMLXSJVqk8NG-plK-cZJetwWjgwLPub_9tQQohWLgJ0q2invJ5C5Imt2ket_-JAlBYLLcnqp_WmOfZkBEWuURsBVirpNQecvpedgeCx4VaFae4qWDI_uKRV1829KCBEH84u6LYUxh8W_BYqkzXJYt99OlHTXHegd91PLT-tawBwuIly46nwbAs5Nt7HFOozxkyPp8BW9URlQW1fE4R_40BXzEuVkzK3WAOdpR92IkV94K_rDZCPltGSvWXtqJbnCpUB6iUIn1V-Ki15FAwh_nsfSmt_NQZ3rQuvyQ9B3yLCQ1ZO_MGSYDYVO26dyXbElspKxQwuNRot9hi3FIbXylV3iN40-nCPH4YQzKjo5p_fuaKhvRh7H8oFjRXtPtLQQUIDxk-jMbOp7gXIsdz02DrCfQIihT4evZuWA6YShl6g8fnAqCy8qRBf_eLDnA9w-nBh4Bq53b1kdhnExz0CMyUjQ43UO3uhMkBomJTXbmfAAHP8dZZao6W8a34OktNQmPTbOHXrtxf6DS-oKOu3l79uX_ihbL8ELT40VjIW3MJeZ_-auCPOjpE3Ax4dzUkSDLCljitmzMagH2X8jN8-AYLl46KcfkBV";
  void myfatoorah(){
    gateway.MFSDK.init(baseUrlDemo,regularPaymentTokenDemo );
    var request = new gateway.MFExecutePaymentRequest("6", total);

    gateway.MFSDK.executePayment(context, request, gateway.MFAPILanguage.AR,
            (String invoiceId, gateway.MFResult<gateway.MFPaymentStatusResponse> result) => {
              getPayRespone(result)
        });
  }

  void getPayRespone(result) {
    if(result.isSuccess()) {
      print(result.response.toJson());
    }else {
      print(result.error.message);
    }
  }
void getCard(){
  gateway.MFSDK.init(baseUrlDemo,regularPaymentTokenDemo );
  var request = new gateway.MFInitiatePaymentRequest(
      double.parse(total), gateway.MFCurrencyISO.SAUDI_ARABIA_SAR);

  gateway.MFSDK.initiatePayment(request, gateway.MFAPILanguage.EN,
  (gateway.MFResult<gateway.MFInitiatePaymentResponse> result) => {
       print(result.response.toJson())
  });
}
  int counter = 1;
  Item item;
  var finalprice;

  var isLog = false;
  Future<bool> isLogin()  async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    isLog = prefs.getBool("isLogin");
    return isLog;
  }
  void reoud(){
    if(isLog == true ){
      myfatoorah();
      print("login ");
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Login()));
    }
  }

  @override
  void initState() {
    super.initState();
    this.isLogin();
    this.getCard();

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return PlatformScaffold(
            appBar: PlatformAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.lightBlue[900],
              title: Text("Cart"),
            ),
            body: cart.basketItems.length == 0
                ? Center(
                child: Text(
                  "No Item Selected",
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                ))
                : ListView(
              children: <Widget>[
                GridView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: cart.basketItems.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0,left: 5.0),
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    color: Colors.grey[100],
                                    height: 90.0,
                                    width: 90.0,
                                    child: wid.Image.network(cart.basketItems[index].product.image[0].url),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Center(
                                      child: Text(
                                        cart.basketItems[index].product.title,
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold,color: Colors.blueAccent,fontSize: 18.0),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Text(
                                      cart.basketItems[index].itemPrice.toString() +
                                          " SAR",
                                      style:
                                      TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Text(
                                      "QTY: "+cart.basketItems[index].quntity.toString(),
                                      style:
                                      TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          PlatformIconButton(
                              onPressed: () {
                                cart.remove(cart.basketItems[index]);
                              },
                              iosIcon: Icon(
                                wid.CupertinoIcons.clear,
                                size: 28.0,
                                color: Colors.red,
                              ),
                              androidIcon: Icon(Icons.close,color: Colors.red,)
                          )
                        ],
                      );
                    }
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Center(
                    child: Text("Total Price: "+ setTotal(cart.basketItems.map((m) => m.itemPrice * m.quntity).reduce((a,b )=>a+b).toString() ) +" SAR",style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 18.0,color: Colors.redAccent),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Center(
                    child: PlatformButton(
                      onPressed: (){
                        //check if the user login or not
                        if (cart.basketItems.length > 0 ) {
                          reoud();
                        }
                      },
                      child: Text('Checkout',style: TextStyle(color: Colors.white),),
                        androidFlat: (_) =>
                            MaterialFlatButtonData(color: Colors.cyan),
                        ios: (_) =>
                            CupertinoButtonData(color: Colors.cyan)
                    ),
                  ),
                )
              ],
                )
        );
      },
    );
  }
  String setTotal(getTotal){
    total = getTotal;
    return total;
  }
}
