import 'package:flutter/material.dart';
import 'package:foody/screen/signIn/android/tablet/landscape/SignInAndroidTabletLandscape.dart';
import 'package:foody/screen/signIn/android/tablet/portrait/SignInAndroidTabletPortrait.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SignInAndroidTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return OrientationLayoutBuilder(
      portrait: (context) => SignInAndroidTabletPortrait(),
      landscape: (context) => SignInAndroidTabletLandscape(),
    );
  }

}