import 'package:flutter/material.dart';
import 'package:foody/screen/Cart/android/tablet/landscape/CartAndroidTabletLandscape.dart';
import 'package:foody/screen/Cart/android/tablet/portrait/CartAndroidTabletPortrait.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CartAndroidTablet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return OrientationLayoutBuilder(
      portrait: (ctx) => CartAndroidTabletPortrait(),
      landscape: (ctx) => CartAndroidTabletLandscape(),
    );
  }

}