import 'package:factory2homes/models/product.dart';
import 'package:factory2homes/screens/cart_screen.dart';
import 'package:factory2homes/services/cart_service.dart';
import 'package:flutter/material.dart';

class ProductDetailsLandingPage extends StatefulWidget {
  final Product product;

  ProductDetailsLandingPage(this.product);

  @override
  _ProductDetailsLandingPageState createState() =>
      _ProductDetailsLandingPageState();
}

class _ProductDetailsLandingPageState extends State<ProductDetailsLandingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CartService _cartService = CartService();
  List<Product> _cartItems;

  @override
  void initState() {
    super.initState();
    _getCartItems();
  }

  _getCartItems() async {
    _cartItems = List<Product>();
    var cartItems = await _cartService.getCartItems();
    cartItems.forEach((data) {
      var product = Product();
      product.productId = data['productId'];

      product.productName = data['productName'];
      product.productListPrice = data['productListPrice'];
      product.productSalePrice = data['productSalePrice'];
      product.productDiscount = data['productDiscount'];
      product.productTax = data['productTax'];
      product.productPhoto = data['productPhoto'];
      product.productDescription = data['productDescription'];
      product.productWarranty = data['productWarranty'];
      product.quantity = data['productQuantity'];

      setState(() {
        _cartItems.add(product);
      });
    });
  }

  _addToCart(BuildContext context, Product product) async {
    var result = await _cartService.addToCart(product);
    if (result > 0) {
      _getCartItems();
      _showSnackMessage(Text(
        'Item added to cart successfully!',
        style: TextStyle(color: Colors.green),
      ));
    } else {
      _showSnackMessage(Text(
        'Failed to add to cart!',
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
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text('Factory2Homes'),
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CartScreen(_cartItems)));
              },
              child: Container(
                child: Stack(children: <Widget>[
                  IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
                  Positioned(
                      child: Stack(
                    children: <Widget>[
                      Icon(
                        Icons.brightness_1,
                        color: Colors.green,
                        size: 25,
                      ),
                      Positioned(
                          top: 4,
                          right: 8,
                          child: Center(
                            child: Text(_cartItems.length.toString()),
                          ))
                    ],
                  ))
                ]),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Image.network(this.widget.product.productPhoto),
                ),
              ),
              Divider(
                thickness: 1,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(this.widget.product.productName),
                ),
              ),
              Divider(),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            '₹' + '${this.widget.product.productSalePrice}',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Center(
                        child: Text(
                            'MRP:' + '${this.widget.product.productListPrice}'),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left:10.0),
                    child: Text('Description',
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                  ),
                ],
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(this.widget.product.productDescription),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          height: 45.0,
          child: RaisedButton(
            onPressed: () {
              _addToCart(context, this.widget.product);
            },
            color: Colors.redAccent,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.card_travel,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    "ADD TO CART",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
