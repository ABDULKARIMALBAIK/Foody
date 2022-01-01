import 'package:flutter/material.dart';
import 'package:foody/screen/signUp/android/mobile/landscape/SignUpAndroidMobileLandscape.dart';
import 'package:foody/screen/signUp/android/mobile/portrait/SignUpAndroidMobilePortrait.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SignUpAndroidMobile extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return OrientationLayoutBuilder(
      portrait: (context) => SignUpAndroidMobilePortrait(),
      landscape: (context) => SignUpAndroidMobileLandscape(),
    );
  }

}