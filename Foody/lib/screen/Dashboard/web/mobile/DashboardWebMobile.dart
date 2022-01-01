import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:foody/constant/Common.dart';
import 'package:foody/localization/app_localizations.dart';
import 'package:foody/route/Routers.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreenWebMobile extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => _SplashScreenWebMobileState();


}

class _SplashScreenWebMobileState extends State<SplashScreenWebMobile>{

  //Navigate to home page after 4 sec
  @override
  void initState() {
    Timer(
        Duration(seconds: 4),
            () => VxNavigator.of(context).clearAndPush(Uri(path: Routers.homeRoute)));
  }

  // Future.delayed(Duration(seconds: 4)).then((value) => VxNavigator.of(context).clearAndPush(Uri(path: Routers.homeRoute)));

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                // Expanded(
                //     child: Center(
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           ShadowedImage(image: Image.asset('images/foody_logo.png')),
                //           SizedBox(height: 40,),
                //           //////////////////////// * Title * ////////////////////////
                //           SizedBox(
                //             width: 400,
                //             child: GlowText(
                //               AppLocalizations.of(Common.context)!.translate('application_name'),
                //               style: Theme.of(Common.context).textTheme.headline3!.copyWith(color: Colors.white),
                //             ),
                //           ),
                //           //////////////////////// * Title * ////////////////////////
                //           SizedBox(height: 30,),
                //           //////////////////////// * SubTitle * ////////////////////////
                //           SizedBox(
                //             width: 700,
                //             child: DefaultTextStyle(
                //               style: Theme.of(Common.context).textTheme.headline4!.copyWith(),
                //               child: AnimatedTextKit(
                //                 animatedTexts: [
                //                   FadeAnimatedText(AppLocalizations.of(Common.context)!.translate('splashScreen_subtitle1')),
                //                   FadeAnimatedText(AppLocalizations.of(Common.context)!.translate('splashScreen_subtitle2')),
                //                   FadeAnimatedText(AppLocalizations.of(Common.context)!.translate('splashScreen_subtitle3')),
                //                 ],
                //                 onTap: () {
                //                   print("Tap Event");
                //                 },
                //               ),
                //             ),
                //           )
                //           //////////////////////// * SubTitle * ////////////////////////
                //         ],
                //       ),
                //     )
                // )
              ],
            ),
          )
      ),
    );
  }
}