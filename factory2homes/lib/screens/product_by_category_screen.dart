import 'dart:convert';

import 'package:factory2homes/models/categories.dart';
import 'package:factory2homes/models/product.dart';
import 'package:factory2homes/screens/product_details_landing_page.dart';
import 'package:factory2homes/services/product_service.dart';
import 'package:flutter/material.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  final Category category;

  ProductsByCategoryScreen({this.category});

  @override
  _ProductsByCategoryScreenState createState() =>
      _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen> {
  ProductService _productService = ProductService();
  List<Product> _productListByCategory = List<Product>();

  _getProductsByCategory() async {
    var products =
        await _productService.getProductsByCategory(this.widget.category.id);
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
        _productListByCategory.add(model);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getProductsByCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(this.widget.category.categoryName),
      ),
      body: Container(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 4,
          ),
          itemCount: _productListByCategory.length,
          itemBuilder: (context, index) {
            return ProductByCategory(this._productListByCategory[index]);
          },
        ),
      ),
    );
  }
}

class ProductByCategory extends StatefulWidget {
  final Product product;

  ProductByCategory(this.product);

  @override
  _ProductByCategoryState createState() => _ProductByCategoryState();
}

class _ProductByCategoryState extends State<ProductByCategory> {
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
              height:150,
              child: Image.network(
                widget.product.productPhoto,
                fit: BoxFit.fitHeight,
              ),
            ),
            Divider(),
            Text(
              this.widget.product.productName,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Row(
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
          ],
        ),
      ),

    );
  }
}
