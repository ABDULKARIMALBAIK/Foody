


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody/bloc/blocUnit/AppBloc.dart';
import 'package:foody/bloc/state/AppBlocState.dart';
import 'package:foody/constant/Common.dart';
import 'package:foody/localization/app_localizations_setup.dart';
import 'package:foody/route/RouterGenerator.dart';
import 'package:foody/route/RouterUnKnownGenerator.dart';
import 'package:foody/route/Routers.dart';
import 'package:foody/style/theme/ThemeAppGenerator.dart';
import 'package:hive/hive.dart';
import 'package:velocity_x/velocity_x.dart';

class AppBuilder {

  Widget get buildWeb {

    var box = Hive.box('foody');
    var darkMode = box.get('darkMode', defaultValue: false);
    var arabicMode = box.get('arabicMode', defaultValue: false);

    var currentLanguage = arabicMode ? Locale('ar') : Locale('en');
    var currentTheme = darkMode ? ThemeAppGenerator.darkTheme : ThemeAppGenerator.lightTheme;

    return BlocProvider<AppBloc>(
      create: (BuildContext context) => AppBloc(currentTheme,currentLanguage),
      child: BlocBuilder<AppBloc, AppBlocState>(
        buildWhen: (oldState,newState) => oldState != newState,
        builder: (context,appState) {

          //Add context to control theme and localization in entire the app
          // Common.context = context;
          // Common.appModel = appState.appModel;

          return MaterialApp.router(
            themeMode: ThemeMode.system,
            debugShowCheckedModeBanner: false,
            title: 'Foody',
            theme: appState.appModel.themeData,
            routeInformationParser: VxInformationParser(),
            routerDelegate: RouteGenerator.generateWeb(context),
            supportedLocales: AppLocalizationsSetup.supportedLocales,
            localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
            localeResolutionCallback: AppLocalizationsSetup.localeResolutionCallback,
            locale: appState.appModel.locale,
          );
        }
      ),
    );
  }

  
  
  Widget get BuildAndroid {

    var box = Hive.box('foody');
    var darkMode = box.get('darkMode', defaultValue: false);
    var arabicMode = box.get('arabicMode', defaultValue: false);

    var currentLanguage = arabicMode ? Locale('ar') : Locale('en');
    var currentTheme = darkMode ? ThemeAppGenerator.darkTheme : ThemeAppGenerator.lightTheme;

    return  BlocProvider<AppBloc>(
      create: (BuildContext context) => AppBloc(currentTheme,currentLanguage),
      child: BlocBuilder<AppBloc, AppBlocState>(
          buildWhen: (oldState,newState) => oldState != newState,
          builder: (context,appState) {

            //Add context to control theme and localization in entire the app
            // Common.context = context;
            // Common.appModel = appState.appModel;

            return MaterialApp(
              themeMode: ThemeMode.system,
              debugShowCheckedModeBanner: true,
              title: 'Foody',
              theme: appState.appModel.themeData,
              supportedLocales: AppLocalizationsSetup.supportedLocales,
              localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
              localeResolutionCallback: AppLocalizationsSetup.localeResolutionCallback,
              locale: appState.appModel.locale,
              onGenerateRoute: RouteGenerator.generateMobileRouter,
              initialRoute: Routers.homeRoute,
            );
          }
      ),
    );
  }

  // static Widget get buildAndroid {
  //   return BlocProvider<AppBloc>(
  //     create: (BuildContext context) => AppBloc(),
  //     child: BlocBuilder<AppBloc, AppBlocState>(
  //         buildWhen: (oldState,newState) => oldState != newState,
  //         builder: (context,appState) {
  //
  //           //Add context to control theme and localization in entire the app
  //           Common.context = context;
  //           Common.appModel = appState.appModel;
  //
  //           return MaterialApp(
  //             themeMode: ThemeMode.system,
  //             debugShowCheckedModeBanner: true,
  //             title: 'Foody',
  //             theme: appState.appModel.themeData,
  //             darkTheme: ThemeAppGenerator.darkTheme,
  //             onGenerateRoute: RouteGenerator.generatePlatforms,
  //             initialRoute: Routers.splashScreenRoute,
  //             onUnknownRoute: RouterUnKnownGenerator.generateAndroid,
  //             supportedLocales: AppLocalizationsSetup.supportedLocales,
  //             localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
  //             localeResolutionCallback: AppLocalizationsSetup.localeResolutionCallback,
  //             locale: appState.appModel.locale,
  //             home: Container(),
  //           );
  //         }
  //     ),
  //   );
  // }

}