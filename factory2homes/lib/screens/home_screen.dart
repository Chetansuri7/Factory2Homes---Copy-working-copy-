import 'package:factory2homes/helpers/side_drawer_navigation.dart';
import 'package:factory2homes/models/categories.dart';
import 'package:factory2homes/models/product.dart';
import 'package:factory2homes/models/slider1.dart';
import 'package:factory2homes/screens/all_categories_home_screen_grid.dart';
import 'package:factory2homes/screens/cart_screen.dart';
import 'package:factory2homes/screens/top_category_grid.dart';
import 'package:factory2homes/services/carousel_slider_service.dart';
import 'package:factory2homes/services/cart_service.dart';
import 'package:factory2homes/services/product_service.dart';
import 'package:factory2homes/widgets/new_swiper_slider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:factory2homes/services/category_service.dart';
import 'package:factory2homes/widgets/new_arrival_homePage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomeScreen extends StatefulWidget {



  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryService _categoryService = CategoryService();
  ProductService _productService = ProductService();
  CarouselSliderService _carouselSliderService = CarouselSliderService();
  CartService _cartService = CartService();

  List<Category> _categoryList = List<Category>();

  List<Category> _topBannerCategoryList = List<Category>();
  List<Sliders> _carouselsliderList = List<Sliders>();

//  List<Product> _productList = List<Product>();
  List<Product> _newArrivalproductList = List<Product>();

//  List<Product> _hotproductList = List<Product>();
  List<Product> _cartItems;
  final FirebaseMessaging _messaging = FirebaseMessaging();



  @override
  void initState() {
    super.initState();
    _getAllCategories();
    _getAllTopCategoryBanner();
    _getAllNewArrivalProducts();
    _getCarouselSlider();
    _getCartItems();
    _messaging.getToken().then((token){
      print(token);
    });
  }

  _getAllCategories() async {
    var categories = await _categoryService.getCategories();
    var result = json.decode(categories.body);
    result['data'].forEach((data) {
      var model = Category();
      model.id = data['id'];
      model.categoryName = data['categoryName'];
      model.categoryIcon = data['categoryIcon'];
      model.categoryKeyword = data['categoryKeyword'];
      setState(() {
        _categoryList.add(model);
      });
    });
  }

  _getCarouselSlider() async {
    var carouselSlider = await _carouselSliderService.getCarouselSlider();
    var result = json.decode(carouselSlider.body);
    result['data'].forEach((data) {
      var model = Sliders();
      model.id = data['id'];
      model.carouselSliderName = data['carouselSliderName'];
      model.carouselSliderImage = data['carouselSliderImage'];
      setState(() {
        _carouselsliderList.add(model);
      });
    });
  }

  _getAllNewArrivalProducts() async {
    var newArrivalProducts = await _productService.getnewArrivalProducts();
    var result = json.decode(newArrivalProducts.body);
    result['data'].forEach((data) {
      var model = Product();
      model.productId = data['productId'];

      model.productName = data['productName'];
      model.productListPrice = data['productListPrice'];
      model.productSalePrice = data['productSalePrice'];
      model.productDiscount = data['productDiscount'];
      model.productTax = data['productTax'];
      model.productPhoto = data['productPhoto'];
      model.productDescription = data['productDescription'];
      model.productWarranty = data['productWarranty'];
      setState(() {
        _newArrivalproductList.add(model);
      });
    });
  }

  _getAllTopCategoryBanner() async {
    var categories = await _categoryService.getTopBannerCategories();
    var result = json.decode(categories.body);
    result['data'].forEach((data) {
      var model = Category();
      model.id = data['id'];
      model.categoryName = data['categoryName'];
      model.categoryIcon = data['categoryIcon'];
      model.categoryKeyword = data['categoryKeyword'];
      setState(() {
        _topBannerCategoryList.add(model);
      });
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Factory2Homes'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
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
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              child: TopCategoryGridView(
                categoriesList: _categoryList,
              ),
            ),
            NewSlider(
              carouselList: _carouselsliderList,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    'Recently Added',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      'View All',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
            HomePageNewArrival(
              productList: _newArrivalproductList,
            ),
            Padding(padding: EdgeInsets.all(5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 4),
                  child: Text(
                    'Browse By Categories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 4),
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      'View All',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
            AllCategoryGridHome(
              categoriesList: _categoryList,
            ),
          ],
        ),
      ),
      drawer: SideDrawerNavigation(),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color(0xFFFF6969),
          unselectedItemColor: Color(0xFF727C8E),
          showUnselectedLabels: true,
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), title: Text("Search")),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), title: Text("Cart")),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text("Profile")),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu), title: Text("More")),
          ]),
    );
  }
}
