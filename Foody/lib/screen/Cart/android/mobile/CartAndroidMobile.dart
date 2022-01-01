import 'package:flutter/material.dart';
import 'package:foody/screen/Cart/android/mobile/landscape/CartAndroidMobileLandscape.dart';
import 'package:foody/screen/Cart/android/mobile/portrait/CartAndroidMobilePortrait.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CartAndroidMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrientationLayoutBuilder(
      portrait: (ctx) => CartAndroidMobilePortrait(),
      landscape: (ctx) => CartAndroidMobileLandscape(),
    );
  }

}