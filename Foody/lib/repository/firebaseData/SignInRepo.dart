import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_oauth/firebase_auth_oauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:foody/constant/Common.dart';
import 'package:foody/constant/Util.dart';
import 'package:foody/localization/app_localizations.dart';
import 'package:foody/route/Routers.dart';
import 'package:foody/widget/SnakBarBuilder.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocity_x/velocity_x.dart';

class SignInRepo {

  signIn(BuildContext context, GlobalKey<ScaffoldState> key, String email, String password , bool isChecked) async {

    //Testing
    print('email is : ' + email);
    print('password is : ' + password);
    print('isChecked is : ' + isChecked.toString());
    var connectivityResult = await (Connectivity().checkConnectivity());
    print('connection :' + connectivityResult.toString());


    if (email.isNotEmpty && password.isNotEmpty) {
      if (Util.validateEmail(email)) {
        if (Util.strongPassword(password)) {
          if(isChecked){
            if (await Util.checkInternet()) {
              try {
                //Sign in Email And Password
                await FirebaseAuth.instance
                    .signInWithEmailAndPassword(email: email, password: password)
                    .then((userCredential) {
                  print('sign in successfully');

                  //Check email is verified
                  if (userCredential.user!.emailVerified) {
                    print('email is verified');

                    //Go to foods
                    Common.currentUser = userCredential.user as User;
                    VxNavigator.of(context)
                        .push(Uri(path: Routers.foodsRoute));
                  }
                  else {
                    print('email is not verified');

                    //Init Dynamic Link
                    ///url:  ........................................................................}
                    var actionCodeSettings = ActionCodeSettings(
                        url: '.....................................',
                        dynamicLinkDomain: ".............................",
                        androidPackageName: ".............................",
                        androidInstallApp: true,
                        androidMinimumVersion: "22",
                        iOSBundleId: "..................................",
                        handleCodeInApp: true);

                    //Send Email Verification
                    userCredential.user!
                        .sendEmailVerification(actionCodeSettings);

                    //SnackBar Send Email
                    SnakBarBuilder.buildAwesomeSnackBar(
                        context,
                        AppLocalizations.of(context)!.translate('home_snackBar_sendEmail_content'),
                        Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                        AwesomeSnackBarType.info);

                    // key.currentState!.showSnackBar(SnakBarBuilder.build(
                    //     context,
                    //     SelectableText(
                    //       AppLocalizations.of(context)!
                    //           .translate('home_snackBar_sendEmail_content'),
                    //       cursorColor: Theme.of(context).primaryColor,
                    //     ),
                    //     AppLocalizations.of(context)!.translate('global_ok'),
                    //         () {print('yes');}));
                  }
                });
              } on FirebaseAuthException catch (e) {
                //User Not Found
                if (e.code == 'user-not-found') {
                  print('No user found for that email.');

                  //SnackBar
                  SnakBarBuilder.buildAwesomeSnackBar(
                      context,
                      AppLocalizations.of(context)!.translate('signIn_snackBar_emailNotFound'),
                      Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                      AwesomeSnackBarType.error);

                  // key.currentState!.showSnackBar(SnakBarBuilder.build(
                  //     context,
                  //     SelectableText(
                  //       AppLocalizations.of(context)!
                  //           .translate('signIn_snackBar_emailNotFound'),
                  //       cursorColor: Theme.of(context).primaryColor,
                  //     ),
                  //     AppLocalizations.of(context)!.translate('global_ok'),
                  //         () {print('yes');}));
                }
                //Wrong Password
                else if (e.code == 'wrong-password') {
                  print('Wrong password provided for that user.');

                  //SnackBar
                  SnakBarBuilder.buildAwesomeSnackBar(
                      context,
                      AppLocalizations.of(context)!.translate('signIn_snackBar_wrongPassword'),
                      Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                      AwesomeSnackBarType.error);

                  // key.currentState!.showSnackBar(SnakBarBuilder.build(
                  //     context,
                  //     SelectableText(
                  //       AppLocalizations.of(context)!
                  //           .translate('signIn_snackBar_wrongPassword'),
                  //       cursorColor: Theme.of(context).primaryColor,
                  //     ),
                  //     AppLocalizations.of(context)!.translate('global_ok'),
                  //         () {print('yes');}));
                }
              }
            }
            //No connection internet
            else {

              //SnackBar
              SnakBarBuilder.buildAwesomeSnackBar(
                  context,
                  AppLocalizations.of(context)!.translate('global_noInternet'),
                  Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                  AwesomeSnackBarType.info);

              // key.currentState!.showSnackBar(SnakBarBuilder.build(
              //     context,
              //     SelectableText(
              //       AppLocalizations.of(context)!.translate('global_noInternet'),
              //       cursorColor: Theme.of(context).primaryColor,
              //     ),
              //     AppLocalizations.of(context)!.translate('global_ok'),
              //         () {print('yes');}));
            }
          }
          //Privacy Policy isn't checked
          else {

            //SnackBar
            SnakBarBuilder.buildAwesomeSnackBar(
                context,
                AppLocalizations.of(context)!.translate('signIn_snackBar_notCheckedPrivacy'),
                Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                AwesomeSnackBarType.error);

            // key.currentState!.showSnackBar(SnakBarBuilder.build(
            //     context,
            //     SelectableText(
            //       AppLocalizations.of(context)!
            //           .translate('signIn_snackBar_notCheckedPrivacy'),
            //       cursorColor: Theme.of(context).primaryColor,
            //     ),
            //     AppLocalizations.of(context)!.translate('global_ok'),
            //         () {print('yes');}));
          }

        }
        //Password is not strong
        else {

          //SnackBar
          SnakBarBuilder.buildAwesomeSnackBar(
              context,
              AppLocalizations.of(context)!.translate('signIn_snackBar_passwordNotString'),
              Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
              AwesomeSnackBarType.error);

          // key.currentState!.showSnackBar(SnakBarBuilder.build(
          //     context,
          //     SelectableText(
          //       AppLocalizations.of(context)!
          //           .translate('signIn_snackBar_passwordNotString'),
          //       cursorColor: Theme.of(context).primaryColor,
          //     ),
          //     AppLocalizations.of(context)!.translate('global_ok'),
          //     () {print('yes');}));
        }
      }
      //Email is not validate
      else {

        //SnackBar
        SnakBarBuilder.buildAwesomeSnackBar(
            context,
            AppLocalizations.of(context)!.translate('signIn_snackBar_emailNotValidate'),
            Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
            AwesomeSnackBarType.error);

        // key.currentState!.showSnackBar(SnakBarBuilder.build(
        //     context,
        //     SelectableText(
        //       AppLocalizations.of(context)!
        //           .translate('signIn_snackBar_emailNotValidate'),
        //       cursorColor: Theme.of(context).primaryColor,
        //     ),
        //     AppLocalizations.of(context)!.translate('global_ok'),
        //     () {print('yes');}));
      }
    }
    //Fields are empty
    else {

      //SnackBar
      SnakBarBuilder.buildAwesomeSnackBar(
          context,
          AppLocalizations.of(context)!.translate('signIn_snackBar_fillFields'),
          Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
          AwesomeSnackBarType.error);

      // key.currentState!.showSnackBar(SnakBarBuilder.build(
      //     context,
      //     SelectableText(
      //       AppLocalizations.of(context)!
      //           .translate('signIn_snackBar_fillFields'),
      //       cursorColor: Theme.of(context).primaryColor,
      //     ),
      //     AppLocalizations.of(context)!.translate('global_ok'),
      //     () {print('yes');}));
    }
  }

  signInGoogleMobile(BuildContext context, GlobalKey<ScaffoldState> key) async {

    if (await Util.checkInternet()) {
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser =
          await GoogleSignIn().signIn() as GoogleSignInAccount;

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Once signed in, return the UserCredential
      FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((userCredential) {
        //Go to foods
        Common.currentUser = userCredential.user as User;
        VxNavigator.of(context).push(Uri(path: Routers.foodsRoute));
      });
    }
    //No Internet
    else {

      //SnackBar
      SnakBarBuilder.buildAwesomeSnackBar(
          context,
          AppLocalizations.of(context)!.translate('global_noInternet'),
          Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
          AwesomeSnackBarType.info);

      // key.currentState!.showSnackBar(SnakBarBuilder.build(
      //     context,
      //     SelectableText(
      //       AppLocalizations.of(context)!.translate('global_noInternet'),
      //       cursorColor: Theme.of(context).primaryColor,
      //     ),
      //     AppLocalizations.of(context)!.translate('global_ok'),
      //     () {print('yes');}));
    }
  }

  signInGoogleWeb(BuildContext context, GlobalKey<ScaffoldState> key) async {
    if (await Util.checkInternet()) {
      // Create a new provider
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider
          .addScope('................................................');
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

      // Once signed in, return the UserCredential
      FirebaseAuth.instance
          .signInWithPopup(googleProvider)
          .then((userCredential) {
        //Go to foods
        Common.currentUser = userCredential.user as User;
        VxNavigator.of(context).push(Uri(path: Routers.foodsRoute));
      });
    }
    //No internet
    else {

      //SnackBar
      SnakBarBuilder.buildAwesomeSnackBar(
          context,
          AppLocalizations.of(context)!.translate('global_noInternet'),
          Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
          AwesomeSnackBarType.info);

      // key.currentState!.showSnackBar(SnakBarBuilder.build(
      //     context,
      //     SelectableText(
      //       AppLocalizations.of(context)!.translate('global_noInternet'),
      //       cursorColor: Theme.of(context).primaryColor,
      //     ),
      //     AppLocalizations.of(context)!.translate('global_ok'),
      //     (){print('yes');}));
    }
  }

  signInFacebookMobile(BuildContext context, GlobalKey<ScaffoldState> key) async {
    if (await Util.checkInternet()) {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential)
          .then((userCredential) {
        //Go to foods
        Common.currentUser = userCredential.user as User;
        VxNavigator.of(context).push(Uri(path: Routers.foodsRoute));
      });
    }
    //No internet
    else {

      //SnackBar
      SnakBarBuilder.buildAwesomeSnackBar(
          context,
          AppLocalizations.of(context)!.translate('global_noInternet'),
          Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
          AwesomeSnackBarType.info);

      // key.currentState!.showSnackBar(SnakBarBuilder.build(
      //     context,
      //     SelectableText(
      //       AppLocalizations.of(context)!.translate('global_noInternet'),
      //       cursorColor: Theme.of(context).primaryColor,
      //     ),
      //     AppLocalizations.of(context)!.translate('global_ok'),
      //     () {print('yes');}));
    }
  }

  signInFacebookWeb(BuildContext context, GlobalKey<ScaffoldState> key) async {
    if (await Util.checkInternet()) {
      // Create a new provider
      FacebookAuthProvider facebookProvider = FacebookAuthProvider();

      facebookProvider.addScope('email');
      facebookProvider.setCustomParameters({
        'display': 'popup',
      });

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance
          .signInWithPopup(facebookProvider)
          .then((userCredential) {
        //Go to foods
        Common.currentUser = userCredential.user as User;
        VxNavigator.of(context).push(Uri(path: Routers.foodsRoute));
      });

      // Or use signInWithRedirect
      // return await FirebaseAuth.instance.signInWithRedirect(facebookProvider);

    }
    //No internet
    else {


      //SnackBar
      SnakBarBuilder.buildAwesomeSnackBar(
          context,
          AppLocalizations.of(context)!.translate('global_noInternet'),
          Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
          AwesomeSnackBarType.info);


      // key.currentState!.showSnackBar(SnakBarBuilder.build(
      //     context,
      //     SelectableText(
      //       AppLocalizations.of(context)!.translate('global_noInternet'),
      //       cursorColor: Theme.of(context).primaryColor,
      //     ),
      //     AppLocalizations.of(context)!.translate('global_ok'),
      //     () {print('yes');}));
    }
  }

  signInMicrosoftMobile(BuildContext context, GlobalKey<ScaffoldState> key) async {
    if (await Util.checkInternet()) {
      FirebaseAuthOAuth().openSignInFlow("microsoft.com", ["email openid"],
          {'tenant': '..................................'}).then((user) {
        //Go to foods
        Common.currentUser = user as User;
        VxNavigator.of(context).push(Uri(path: Routers.foodsRoute));
      });
    }
    //No internet
    else {

      //SnackBar
      SnakBarBuilder.buildAwesomeSnackBar(
          context,
          AppLocalizations.of(context)!.translate('global_noInternet'),
          Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
          AwesomeSnackBarType.info);


      // key.currentState!.showSnackBar(SnakBarBuilder.build(
      //     context,
      //     SelectableText(
      //       AppLocalizations.of(context)!.translate('global_noInternet'),
      //       cursorColor: Theme.of(context).primaryColor,
      //     ),
      //     AppLocalizations.of(context)!.translate('global_ok'),
      //     (){print('yes');}));
    }
  }

  signInMicrosoftWeb(BuildContext context, GlobalKey<ScaffoldState> key) async {

    if (await Util.checkInternet()) {
      FirebaseAuthOAuth().openSignInFlow("microsoft.com", ["email openid"],
          {'tenant': '.............................'}).then((user){
            //Go to Dashboard
            Common.currentUser = user as User;
            VxNavigator.of(context).push(Uri(path: Routers.foodsRoute));
      });
    }
    //No internet
    else {

      //SnackBar
      SnakBarBuilder.buildAwesomeSnackBar(
          context,
          AppLocalizations.of(context)!.translate('global_noInternet'),
          Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
          AwesomeSnackBarType.info);


      // key.currentState!.showSnackBar(SnakBarBuilder.build(
      //     context,
      //     SelectableText(
      //       AppLocalizations.of(context)!.translate('global_noInternet'),
      //       cursorColor: Theme.of(context).primaryColor,
      //     ),
      //     AppLocalizations.of(context)!.translate('global_ok'),
      //     () {print('yes');}));
    }
  }
}
