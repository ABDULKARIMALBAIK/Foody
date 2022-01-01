import 'package:flutter/material.dart';
import 'package:foody/screen/signUp/android/tablet/landscape/SignUpAndroidTabletLandscape.dart';
import 'package:foody/screen/signUp/android/tablet/portrait/SignUpAndroidTabletPortrait.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SignUpAndroidTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return OrientationLayoutBuilder(
      portrait: (context) => SignUpAndroidTabletPortrait(),
      landscape: (context) => SignUpAndroidTabletLandscape(),
    );
  }

}