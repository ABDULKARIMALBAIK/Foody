import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foody/constant/Common.dart';
import 'package:foody/localization/app_localizations.dart';
import 'package:foody/route/Routers.dart';
import 'package:foody/widget/SnakBarBuilder.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeRepoFirebase {

  listen(BuildContext context, GlobalKey<ScaffoldState> key) {
    FirebaseAuth.instance
        .userChanges()
        .listen((User? user) {

      if (user == null) {
        print('User is currently signed out!');
      }
      else {
        print('User is signed in!');
        
        if(user.emailVerified){
          print('Email is verified !!!!!!!!');
          Common.currentUser = user;
          VxNavigator.of(context).push(Uri(path: Routers.dashboardRoute));
        }
        else{
          print('Email isn not verified');

          key.currentState!.showSnackBar(
              SnakBarBuilder.build(
                  context,
                  SelectableText(
                    AppLocalizations.of(context)!.translate('home_snackBar_sendEmail_content'),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                    cursorColor: Theme.of(context).primaryColor,
                  ),
                  AppLocalizations.of(context)!.translate('home_snackBar_sendEmail_action'),
                  () async => await user.sendEmailVerification())
              );
        }
      }
    });
  }

}
