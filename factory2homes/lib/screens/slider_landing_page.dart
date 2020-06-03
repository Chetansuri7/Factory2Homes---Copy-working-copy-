import 'dart:convert';
import 'package:factory2homes/models/product.dart';
import 'package:factory2homes/models/slider1.dart';
import 'package:factory2homes/screens/product_details_landing_page.dart';
import 'package:factory2homes/services/product_service.dart';
import 'package:flutter/material.dart';

class ProductsBySliderScreen extends StatefulWidget {
  final Sliders sliders;

  ProductsBySliderScreen({this.sliders});

  @override
  _ProductsBySliderScreenState createState() => _ProductsBySliderScreenState();
}

class _ProductsBySliderScreenState extends State<ProductsBySliderScreen> {
  ProductService _productService = ProductService();
  List<Product> _productListBySlider = List<Product>();

  _getProductsBySlider() async {
    var products =
        await _productService.getProductsBySlider(this.widget.sliders.id);
    var _list = json.decode(products.body);
    _list['data'].forEach((data) {
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
        _productListBySlider.add(model);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getProductsBySlider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(this.widget.sliders.carouselSliderName),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3/4,
        ),
        itemCount: _productListBySlider.length,
        itemBuilder: (context, index) {
          return ProductsBySlider(this._productListBySlider[index]);
        },
      ),
    );
  }
}

class ProductsBySlider extends StatefulWidget {
  final Product product;

  ProductsBySlider(this.product);

  @override
  _ProductsBySliderState createState() => _ProductsBySliderState();
}

class _ProductsBySliderState extends State<ProductsBySlider> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProductDetailsLandingPage(this.widget.product)));
      },
      child: Card(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 150,
              child: Image.network(
                widget.product.productPhoto,
                fit: BoxFit.fitHeight,
              ),
            ),
            Divider(),
            Container(

              child: Text(

                this.widget.product.productName,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    '₹: ${this.widget.product.productSalePrice}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  Text('MRP: ${this.widget.product.productListPrice}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
