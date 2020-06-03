import 'package:factory2homes/models/product.dart';
import 'package:factory2homes/screens/checkout_screen.dart';
import 'package:factory2homes/screens/login_screen.dart';
import 'package:factory2homes/services/cart_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  final List<Product> cartItems;

  CartScreen(this.cartItems);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double _total;
  CartService _cartService = CartService();

  @override
  void initState() {
    super.initState();
    _getTotal();
  }

  _getTotal() {
    _total = 0.0;
    this.widget.cartItems.forEach((item) {
      setState(() {
        _total += (item.productListPrice) * item.quantity;
      });
    });
  }

  void _checkOut(List<Product> cartItems) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int _userId = _prefs.getInt('userId');
    if (_userId != null && _userId > 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CheckOutScreen(cartItems: cartItems)));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(cartItems: cartItems)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CheckOut'),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          )
        ],
      ),
      body: ListView.separated(
        itemCount: this.widget.cartItems.length,
        separatorBuilder: (context, index) {
          return Divider(
            height: 1,
            color: Colors.green,
          );
        },
        itemBuilder: (context, index) {
          return Container(
            height: MediaQuery.of(context).size.height / 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        this.widget.cartItems[index].productPhoto,
                        fit: BoxFit.fitHeight,
                      )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        this.widget.cartItems[index].productName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height / 20,
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() {
                                      if (this
                                              .widget
                                              .cartItems[index]
                                              .quantity >
                                          1) {
                                        _total -= this
                                            .widget
                                            .cartItems[index]
                                            .productSalePrice;
                                        this.widget.cartItems[index].quantity--;
                                      }
                                    });
                                  },
                                  iconSize: 10,
                                ),
                                Text(
                                  '${this.widget.cartItems[index].quantity}',
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        _total += this
                                            .widget
                                            .cartItems[index]
                                            .productSalePrice;
                                        this.widget.cartItems[index].quantity++;
                                      });
                                    },
                                    iconSize: 10),
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 20,
                        child: RaisedButton(
                            color: Colors.redAccent,
                            child: Text(
                              'Remove',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              setState(() {
                                _deleteCartItem(index,
                                    this.widget.cartItems[index].productId);
                              });
                            }),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 5,
                  child: Center(
                    child: Text(
                        '${this.widget.cartItems[index].productSalePrice * this.widget.cartItems[index].quantity}'),
                  ),
                )
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height / 11,
        color: Colors.blueGrey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: Text(
                "Rs. " + "$_total",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 16,
              child: FlatButton(
                  onPressed: () {
                    _checkOut(this.widget.cartItems);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.green,
                  child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        'CHECKOUT',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ))),
            )
          ],
        ),
      ),
    );
  }

  void _deleteCartItem(int index, int productId) async {
    setState(() {
      this.widget.cartItems.removeAt(index);
    });
    var result = await _cartService.deleteCartItemById(productId);
  }
}
