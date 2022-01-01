import 'package:flutter/material.dart';
import 'package:foody/screen/signIn/android/mobile/landscape/SignInAndroidMobileLandscape.dart';
import 'package:foody/screen/signIn/android/mobile/portrait/SignInAndroidMobilePortrait.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SignInAndroidMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return OrientationLayoutBuilder(
      portrait: (context) => SignInAndroidMobilePortrait(),
      landscape: (context) => SignInAndroidMobileLandscape(),
    );
  }

}