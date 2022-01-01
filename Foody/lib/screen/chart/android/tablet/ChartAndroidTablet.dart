import 'package:flutter/material.dart';
import 'package:foody/screen/chart/android/tablet/landscape/ChartAndroidTabletLandscape.dart';
import 'package:foody/screen/chart/android/tablet/portrait/ChartAndroidTabletPortrait.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ChartAndroidTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrientationLayoutBuilder(
      portrait: (ctx) => ChartAndroidTabletPortrait(),
      landscape: (ctx) => ChartAndroidTabletLandscape(),
    );
  }

}