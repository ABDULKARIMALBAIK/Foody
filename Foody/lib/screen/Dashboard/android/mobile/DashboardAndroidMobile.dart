import 'package:flutter/material.dart';
import 'package:foody/screen/Dashboard/android/mobile/landscape/DashboardAndroidMobileLandscape.dart';
import 'package:foody/screen/Dashboard/android/mobile/portrait/DashboardAndroidMobilePortrait.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DashboardAndroidMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrientationLayoutBuilder(
      portrait: (ctx) => DashboardAndroidMobilePortrait(),
      landscape: (ctx) => DashboardAndroidMobileLandscape(),
    );
  }

}