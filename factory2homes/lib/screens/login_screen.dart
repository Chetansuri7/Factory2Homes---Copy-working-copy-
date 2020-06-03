import 'dart:convert';


import 'package:factory2homes/models/product.dart';
import 'package:factory2homes/models/user.dart';
import 'package:factory2homes/screens/checkout_screen.dart';
import 'package:factory2homes/screens/home_screen.dart';
import 'package:factory2homes/screens/registration_screen.dart';
import 'package:factory2homes/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  final List<Product> cartItems;

  LoginScreen({this.cartItems});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setSharedPrefs();
  }

  _setSharedPrefs() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setInt('userId', 0);
    _prefs.setString('userName', '');
    _prefs.setString('userEmail', '');
  }

  _login(BuildContext context, User user) async {
    var _userService = UserService();

    var registeredUser = await _userService.login(user);
    var result = json.decode(registeredUser.body);

    if (result['result'] == true) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();

      _prefs.setInt('userId', result['user']['id']);
      _prefs.setString('userName', result['user']['name']);
      _prefs.setString('userEmail', result['user']['email']);

      if (this.widget.cartItems != null && this.widget.cartItems.length > 0) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CheckOutScreen(
                  cartItems: this.widget.cartItems,
                )));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } else {
      _showSnackMessage(Text(
        'Failed to login!',
        style: TextStyle(color: Colors.red),
      ));
    }
  }

  _showSnackMessage(message) {
    var snackBar = SnackBar(
      content: message,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 120),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 48.0, top: 14.0, right: 48.0, bottom: 14.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                autofocus: false,

                controller: email,
                decoration: InputDecoration(
                    hintText: 'youremail@example.com',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),

                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 48.0, top: 14.0, right: 48.0, bottom: 14.0),
              child: TextField(
                autofocus: false,


                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    hintText: 'Enter your password'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 48.0, top: 14.0, right: 48.0, bottom: 14.0),
              child: Container(
                height: 48,
                child: RaisedButton(

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  onPressed: () {
                    var user = User();
                    user.email = email.text;
                    user.password = password.text;
                    _login(context, user);
                  },
                  color: Colors.redAccent,
                  padding: EdgeInsets.all(12),


                  child: Text(
                    'Log in',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegistrationScreen(
                          cartItems: this.widget.cartItems,
                        )));
              },

              child: FittedBox(child: Text('Register your account')),
            ),
          ],
        ),
      ),
    );
  }
}
