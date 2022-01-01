import 'package:flutter/material.dart';
import 'package:foody/screen/chart/android/mobile/landscape/ChartAndroidMobileLandscape.dart';
import 'package:foody/screen/chart/android/mobile/portrait/ChartAndroidMobilePortrait.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ChartAndroidMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrientationLayoutBuilder(
      portrait: (ctx) => ChartAndroidMobilePortrait(),
      landscape: (ctx) => ChartAndroidMobileLandscape(),
    );
  }

}