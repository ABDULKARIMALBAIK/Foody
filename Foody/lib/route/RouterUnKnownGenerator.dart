import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RouterUnKnownGenerator{

  static Route? generateAndroid(RouteSettings settings) {
    return PageTransition(
      settings: settings,
      child: Container(color: Colors.cyan,),
      type: PageTransitionType.fade,
    );
  }
}