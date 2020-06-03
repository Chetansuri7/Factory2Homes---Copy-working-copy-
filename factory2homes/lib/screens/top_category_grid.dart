import 'package:factory2homes/models/categories.dart';
import 'package:factory2homes/screens/product_by_category_screen.dart';
import 'package:flutter/material.dart';

class TopCategoryGridView extends StatefulWidget {
  final List<Category> categoriesList;

  TopCategoryGridView({this.categoriesList});

  @override
  _TopCategoryGridViewState createState() => _TopCategoryGridViewState();
}

class _TopCategoryGridViewState extends State<TopCategoryGridView> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: this.widget.categoriesList.length,
          itemBuilder: (context, index) {
            return TopCategoryGridViewProductList(
              this.widget.categoriesList[index]
            );
          }),
    );
  }
}

class TopCategoryGridViewProductList extends StatefulWidget {
  final Category category;

  TopCategoryGridViewProductList(this.category);

  @override
  _TopCategoryGridViewProductListState createState() =>
      _TopCategoryGridViewProductListState();
}

class _TopCategoryGridViewProductListState
    extends State<TopCategoryGridViewProductList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductsByCategoryScreen(category: this.widget.category,)));
          },
          child: Card(
            child: Container(
                height: 75,
                width: MediaQuery.of(context).size.width / 6,
                child: Image.network(
                  widget.category.categoryIcon,
                )),
          ),
        ),
        Text(
          this.widget.category.categoryName,
          style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
