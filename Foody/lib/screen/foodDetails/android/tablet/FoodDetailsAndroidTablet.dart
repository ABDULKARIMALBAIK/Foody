import 'package:flutter/material.dart';
import 'package:foody/screen/foodDetails/android/tablet/landscape/FoodDetailsAndroidTabletLandscape.dart';
import 'package:foody/screen/foodDetails/android/tablet/portrait/FoodDetailsAndroidTabletPortrait.dart';
import 'package:responsive_builder/responsive_builder.dart';

class FoodDetailsAndroidTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrientationLayoutBuilder(
      portrait: (ctx) => FoodDetailsAndroidTabletPortrait(),
      landscape: (ctx) => FoodDetailsAndroidTabletLandscape(),
    );
  }

}