import 'package:flutter/material.dart';
import 'package:foody/screen/home/android/mobile/landscape/HomeAndroidMobileLandscape.dart';
import 'package:foody/screen/home/android/mobile/portrait/HomeAndroidMobilePortrait.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeAndroidMobile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return OrientationLayoutBuilder(
      portrait: (context) => HomeAndroidMobilePortrait(),
      landscape: (context) => HomeAndroidMobileLandscape(),
    );
  }

}