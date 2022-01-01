import 'package:flutter/material.dart';
import 'package:foody/route/Routers.dart';

class HomeProcessor {

  void navigateToSignIn(context){
    Navigator.of(context).pushNamed(Routers.signInRoute);
  }

}