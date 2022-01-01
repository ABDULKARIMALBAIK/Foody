import 'package:flutter/material.dart';
import 'package:foody/model/modelNetwork/Food.dart';
import 'package:foody/screen/foodDetails/android/mobile/landscape/FoodDetailsAndroidMobileLandscape.dart';
import 'package:foody/screen/foodDetails/android/mobile/portrait/FoodDetailsAndroidMobilePortrait.dart';
import 'package:responsive_builder/responsive_builder.dart';

class FoodDetailsAndroidMobile extends StatelessWidget {

  Food food;


  FoodDetailsAndroidMobile(this.food);

  @override
  Widget build(BuildContext context) {
    return OrientationLayoutBuilder(
      portrait: (ctx) => FoodDetailsAndroidMobilePortrait(food),
      landscape: (ctx) => FoodDetailsAndroidMobileLandscape(),
    );
  }

}