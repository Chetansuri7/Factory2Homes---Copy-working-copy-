import 'package:factory2homes/helpers/page_route_animation.dart';
import 'package:factory2homes/screens/slider_landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:factory2homes/models/slider1.dart';

class NewSlider extends StatefulWidget {
  final List<Sliders> carouselList;


  NewSlider({this.carouselList});

  @override
  _NewSliderState createState() => _NewSliderState();
}

class _NewSliderState extends State<NewSlider> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: Container(
        height: MediaQuery.of(context).size.height/4,
        child: Swiper(
            autoplay: false,
            autoplayDelay: 3000,
            itemCount: this.widget.carouselList.length,
            pagination: new SwiperPagination(),


            itemBuilder: (context, index) {
              return NewSliderProductList(this.widget.carouselList[index]);
            }),
      ),
    );
  }
}

class NewSliderProductList extends StatefulWidget {
  final Sliders slider1;


  NewSliderProductList(this.slider1);

  @override
  _NewSliderProductListState createState() => _NewSliderProductListState();
}

class _NewSliderProductListState extends State<NewSliderProductList> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){


        Navigator.push(
            context, PageRouteAnimation(widget: ProductsBySliderScreen(sliders: this.widget.slider1,)));


      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
          child: Image.network(
        this.widget.slider1.carouselSliderImage,
        fit: BoxFit.fill,
      )),
    );
  }
}
