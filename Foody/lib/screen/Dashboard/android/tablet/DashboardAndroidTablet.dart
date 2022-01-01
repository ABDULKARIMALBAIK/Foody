import 'package:flutter/material.dart';
import 'package:foody/screen/Dashboard/android/tablet/landscape/DashboardAndroidTabletLandscape.dart';
import 'package:foody/screen/Dashboard/android/tablet/portrait/DashboardAndroidTabletPortrait.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DashboardAndroidTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrientationLayoutBuilder(
      portrait: (ctx) => DashboardAndroidTabletPortrait(),
      landscape: (ctx) => DashboardAndroidTabletLandscape(),
    );
  }

}