import 'package:factory2homes/models/categories.dart';
import 'package:factory2homes/screens/product_by_category_screen.dart';
import 'package:flutter/material.dart';

class AllCategoryGridHome extends StatefulWidget {
  final List<Category> categoriesList;

  AllCategoryGridHome({this.categoriesList});

  @override
  _AllCategoryGridHomeState createState() => _AllCategoryGridHomeState();
}

class _AllCategoryGridHomeState extends State<AllCategoryGridHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.95,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
          ),
          scrollDirection: Axis.vertical,
          itemCount: this.widget.categoriesList.length,
          itemBuilder: (context, index) {
            return AllCategoryGridHomeProductList(
                this.widget.categoriesList[index]);
          }),
    );
  }
}

class AllCategoryGridHomeProductList extends StatefulWidget {
  final Category category;
  AllCategoryGridHomeProductList(this.category);

  @override
  _AllCategoryGridHomeProductListState createState() =>
      _AllCategoryGridHomeProductListState();
}

class _AllCategoryGridHomeProductListState
    extends State<AllCategoryGridHomeProductList> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductsByCategoryScreen(category: this.widget.category,)));
      },
      child: Card(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: size.height/9,
                  width: double.infinity,
                  child: Image.network(
                    this.widget.category.categoryIcon,
                  )),
              Text(
                this.widget.category.categoryName,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
