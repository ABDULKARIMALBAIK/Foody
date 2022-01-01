import 'package:flutter/material.dart';
import 'package:foody/screen/foods/android/mobile/landscape/FoodsAndroidMobileLandscape.dart';
import 'package:foody/screen/foods/android/mobile/portrait/FoodsAndroidMobilePortrait.dart';
import 'package:responsive_builder/responsive_builder.dart';

class FoodsAndroidMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrientationLayoutBuilder(
      portrait: (ctx) => FoodsAndroidMobilePortrait(),
      landscape: (ctx) => FoodsAndroidMobileLandscape(),
    );
  }

}