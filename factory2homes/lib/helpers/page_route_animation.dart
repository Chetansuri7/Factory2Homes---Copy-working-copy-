import 'package:flutter/material.dart';

class PageRouteAnimation extends PageRouteBuilder {
  final Widget widget;

  PageRouteAnimation({this.widget})
      : super(

            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimationm,
                Widget child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.ease);

              return ScaleTransition(
                alignment: Alignment.center,
                scale: animation,
                child: child,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secAnimation) {
              return widget;
            });
}
