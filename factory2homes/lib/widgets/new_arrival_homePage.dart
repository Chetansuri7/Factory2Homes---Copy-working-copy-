import 'package:factory2homes/helpers/page_route_animation.dart';
import 'package:factory2homes/models/product.dart';
import 'package:factory2homes/screens/product_details_landing_page.dart';
import 'package:flutter/material.dart';

class HomePageNewArrival extends StatefulWidget {
  final List<Product> productList;

  HomePageNewArrival({this.productList});

  @override
  _HomePageNewArrivalState createState() => _HomePageNewArrivalState();
}

class _HomePageNewArrivalState extends State<HomePageNewArrival> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: FutureBuilder(
          future: Future.delayed(Duration(milliseconds: 200)),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                      ),
                      itemCount: this.widget.productList.length,
                      itemBuilder: (context, index) {
                        return HomeNewArrivalProducts(
                            this.widget.productList[index]);
                      })),
    );
  }
}

class HomeNewArrivalProducts extends StatefulWidget {
  final Product product;

  HomeNewArrivalProducts(this.product);

  @override
  _HomeNewArrivalProductsState createState() => _HomeNewArrivalProductsState();
}

class _HomeNewArrivalProductsState extends State<HomeNewArrivalProducts> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, PageRouteAnimation(widget: ProductDetailsLandingPage(this.widget.product)));
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: SizedBox(
                height: 85,
                width: double.infinity,
                child: Image.network(
                  this.widget.product.productPhoto,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Divider(),
            Text(
              this.widget.product.productName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 9, top: 5),
              child: Text('Price: ${this.widget.product.productSalePrice}'),
            ),
          ],
        ),
      ),
    );
  }
}
