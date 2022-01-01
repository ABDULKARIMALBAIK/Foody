import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:foody/localization/app_localizations.dart';
import 'package:foody/route/Routers.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreenWebDesktop extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => _SplashScreenWebDesktopState();
}

class _SplashScreenWebDesktopState extends State<SplashScreenWebDesktop>{

  //Navigate to home page after 4 sec
  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              //////////////////////// * Drawer * ////////////////////////
              Expanded(
                  flex: 1,
                  child: Container()
              )
              //////////////////////// * Foods * ////////////////////////
              // Expanded(
              //     flex: 5,
              //     child: BlocProvider<>(
              //       create: ,
              //       child: BlocBuilder<>(
              //         buildWhen: (oldState,newState) => oldState != newState,
              //         builder: (context,state),
              //       ),
              //     )
              // ),
            ],
          ),
        ),
      ),
    );
  }
}