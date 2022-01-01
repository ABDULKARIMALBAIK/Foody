import 'package:flutter/material.dart';
import 'package:foody/screen/foods/android/tablet/landscape/FoodsAndroidTabletLandscape.dart';
import 'package:foody/screen/foods/android/tablet/portrait/FoodsAndroidTabletPortrait.dart';
import 'package:responsive_builder/responsive_builder.dart';

class FoodsAndroidTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrientationLayoutBuilder(
      portrait: (ctx) => FoodsAndroidTabletPortrait(),
      landscape: (ctx) => FoodsAndroidTabletLandscape(),
    );
  }

}