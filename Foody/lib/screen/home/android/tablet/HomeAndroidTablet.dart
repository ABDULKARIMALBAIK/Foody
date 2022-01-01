import 'package:flutter/material.dart';
import 'package:foody/screen/home/android/tablet/landscape/HomeAndroidTabletLandscape.dart';
import 'package:foody/screen/home/android/tablet/portrait/HomeAndroidTabletPortrait.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeAndroidTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return OrientationLayoutBuilder(
      portrait: (context) => HomeAndroidTabletPortrait(),
      landscape: (context) => HomeAndroidTabletLandscape(),
    );
  }

}