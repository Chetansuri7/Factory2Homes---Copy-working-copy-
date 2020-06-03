import 'package:factory2homes/models/payment.dart';
import 'package:factory2homes/models/product.dart';
import 'package:factory2homes/screens/home_screen.dart';
import 'package:factory2homes/services/cart_service.dart';
import 'package:factory2homes/services/payment_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';

class PaymentScreen extends StatefulWidget {
  List<Product> cartItems;
  PaymentScreen({this.cartItems});
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _cardHolderName = TextEditingController();
  final _cardHolderEmail = TextEditingController();
  final _cardNumber = TextEditingController();
  final _expiryMonth = TextEditingController();
  final _expiryYear = TextEditingController();
  final _cvcNumber = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Make payment'),
        backgroundColor: Colors.redAccent,
        leading: Text(''),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 28.0, right: 28.0, bottom: 14.0),
              child: Text('Make payment',
                  style:
                  TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
            ),
            Divider(
              height: 5.0,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _cardHolderEmail,
                decoration: InputDecoration(hintText: 'Email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
              child: TextField(
                controller: _cardHolderName,
                decoration: InputDecoration(hintText: 'Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
              child: TextField(
                controller: _cardNumber,
                decoration: InputDecoration(
                  hintText: 'Card Number',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
              child: TextField(
                controller: _expiryMonth,
                decoration: InputDecoration(
                  hintText: 'Expiry Month',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
              child: TextField(
                controller: _expiryYear,
                decoration: InputDecoration(
                  hintText: 'Expiry Year',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
              child: TextField(
                controller: _cvcNumber,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'CVC',
                ),
              ),
            ),
            Column(
              children: <Widget>[
                ButtonTheme(
                  minWidth: 320.0,
                  height: 45.0,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0)),
                    color: Colors.redAccent,
                    onPressed: () async {
                      SharedPreferences _prefs =
                          await SharedPreferences.getInstance();
                      var payment = Payment();
                      payment.userId = _prefs.getInt('userId');
                      payment.name = _cardHolderName.text;
                      payment.email = _cardHolderEmail.text;
                      payment.cardNumber = _cardNumber.text;
                      payment.expiryMonth = _expiryMonth.text;
                      payment.expiryYear = _expiryYear.text;
                      payment.cvcNumber = _cvcNumber.text;
                      payment.cartItems = this.widget.cartItems;
                      _makePayment(context, payment);

                    },
                    child: Text('Make Payment',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _makePayment(BuildContext context, Payment payment) async {
    PaymentService _paymentService = PaymentService();
    var paymentData = await _paymentService.makePayment(payment);
    var result = json.decode(paymentData.body);
        if (result['result'] == true) {
      CartService _cartService = CartService();
      this.widget.cartItems.forEach((cartItem){
        _cartService.deleteCartItemById(cartItem.productId);
      });
      _showPaymentSuccessMessage(context);
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    }
  }

  _showPaymentSuccessMessage(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Container(
              height: 360,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/success.png'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Order & Payment is successfully done!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
