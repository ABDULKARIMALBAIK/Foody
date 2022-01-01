import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foody/constant/Common.dart';
import 'package:foody/constant/Util.dart';
import 'package:foody/localization/app_localizations.dart';
import 'package:foody/route/Routers.dart';
import 'package:foody/widget/SnakBarBuilder.dart';
import 'package:moor/moor.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth_oauth/firebase_auth_oauth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SignUpRepo {

  signUp(BuildContext context , GlobalKey<ScaffoldState> key ,
      String email , String password , String name , String phoneNumber , String address , bool isChecked , Uint8List pickImage) async{

    //Testing
    print('email is : ' + email);
    print('password is : ' + password);
    print('name is : ' + name);
    print('phoneNumber is : ' + phoneNumber);
    print('address is : ' + address);
    print('isChecked is : ' + isChecked.toString());


    if(email.isNotEmpty && password.isNotEmpty && name.isNotEmpty && phoneNumber.isNotEmpty && address.isNotEmpty){
      if(Util.validateEmail(email)){
        if(Util.strongPassword(password)){
          if(name.isLetter()){
            if(Util.validPhoneNumber(phoneNumber)){
              if(isChecked){
                if(await Util.checkInternet()){

                  try {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email,
                        password: password
                    ).then((userCredential) async{

                      //sign up successfully
                      print('sign up successfully');
                      //Put some data
                      User currentUser = FirebaseAuth.instance.currentUser as User;
                      currentUser.updateDisplayName(name);



                      //check user's email is verified
                      if(userCredential.user!.emailVerified){
                        print('email is verified');




                        //Upload Image of user
                        firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
                            .ref('users/${Random().nextInt(10000)}.jpg');

                        // Upload raw data.
                        await ref.putData(pickImage);

                        //Get url of signature
                        String urlImageUser = await ref.getDownloadURL();





                        //Update user's data (Email and password is ok , address isn't needed)
                        FirebaseAuth.instance.currentUser!.updateDisplayName(name);
                        FirebaseAuth.instance.currentUser!.updatePhotoURL(urlImageUser);

                        //Can't update phone number because it is difficult to change !!!!!!!!!
                        //FirebaseAuth.instance.currentUser!.updatePhoneNumber(phoneNumber ????);





                        //Go to foods
                        Common.currentUser = userCredential.user as User;
                        VxNavigator.of(context).push(Uri(path: Routers.foodsRoute));


                      }
                      else {
                        print('email is not verified');

                        //Init Dynamic Link
                        ///url:  .............................................................}
                        var actionCodeSettings = ActionCodeSettings(
                            url: '...................................',
                            dynamicLinkDomain: "..........................",
                            androidPackageName: "............................",
                            androidInstallApp: true,
                            androidMinimumVersion: "22",
                            iOSBundleId: "............................",
                            handleCodeInApp: true);

                        userCredential.user!.sendEmailVerification(actionCodeSettings);


                        //SnackBar
                        SnakBarBuilder.buildAwesomeSnackBar(
                            context,
                            AppLocalizations.of(context)!.translate('home_snackBar_sendEmail_content'),
                            Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                            AwesomeSnackBarType.info);

                        // key.currentState!.showSnackBar(
                        //     SnakBarBuilder.build(
                        //         context,
                        //         SelectableText(
                        //           AppLocalizations.of(context)!.translate('home_snackBar_sendEmail_content'),
                        //           cursorColor: Theme.of(context).primaryColor,
                        //         ),
                        //         AppLocalizations.of(context)!.translate('global_ok'),
                        //             () {print('yes');}));


                      }

                    });
                  }
                  on FirebaseAuthException catch (e) {
                    //Password is weak
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');

                      //SnackBar
                      SnakBarBuilder.buildAwesomeSnackBar(
                          context,
                          AppLocalizations.of(context)!.translate('signUp_snackBar_weakPassword'),
                          Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                          AwesomeSnackBarType.error);


                      // key.currentState!.showSnackBar(
                      //     SnakBarBuilder.build(
                      //         context,
                      //         SelectableText(
                      //           AppLocalizations.of(context)!.translate('signUp_snackBar_weakPassword'),
                      //           cursorColor: Theme.of(context).primaryColor,
                      //         ),
                      //         AppLocalizations.of(context)!.translate('global_ok'),
                      //             ()  {print('yes');}));
                    }
                    //Email is already used
                    else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');

                      //SnackBar
                      SnakBarBuilder.buildAwesomeSnackBar(
                          context,
                          AppLocalizations.of(context)!.translate('signUp_snackBar_alreadyUsed'),
                          Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                          AwesomeSnackBarType.info);

                      // key.currentState!.showSnackBar(
                      //     SnakBarBuilder.build(
                      //         context,
                      //         SelectableText(
                      //           AppLocalizations.of(context)!.translate('signUp_snackBar_alreadyUsed'),
                      //           cursorColor: Theme.of(context).primaryColor,
                      //         ),
                      //         AppLocalizations.of(context)!.translate('global_ok'),
                      //             (){print('yes');}));
                    }
                  }
                  catch (e) {
                    print(e.toString());
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


                  // key.currentState!.showSnackBar(
                  //     SnakBarBuilder.build(
                  //         context,
                  //         SelectableText(
                  //           AppLocalizations.of(context)!.translate('global_noInternet'),
                  //           cursorColor: Theme.of(context).primaryColor,
                  //         ),
                  //         AppLocalizations.of(context)!.translate('global_ok'),
                  //             (){print('yes');})
                  // );
                }
              }
              //Privacy Policy Check
              else {

                //SnackBar
                SnakBarBuilder.buildAwesomeSnackBar(
                context,
                AppLocalizations.of(context)!.translate('signIn_snackBar_notCheckedPrivacy'),
                Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                AwesomeSnackBarType.error);

                // key.currentState!.showSnackBar(
                //     SnakBarBuilder.build(
                //         context,
                //         SelectableText(
                //           AppLocalizations.of(context)!.translate('signIn_snackBar_notCheckedPrivacy'),
                //           cursorColor: Theme.of(context).primaryColor,
                //         ),
                //         AppLocalizations.of(context)!.translate('global_ok'),
                //             () {print('yes');}));
              }
            }
            //phone Number is not validate
            else {

              //SnackBar
              SnakBarBuilder.buildAwesomeSnackBar(
                  context,
                  AppLocalizations.of(context)!.translate('signUp_snackBar_currentPhone'),
                  Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                  AwesomeSnackBarType.error);


              // key.currentState!.showSnackBar(
              //     SnakBarBuilder.build(
              //         context,
              //         SelectableText(
              //           AppLocalizations.of(context)!.translate('signUp_snackBar_currentPhone'),
              //           cursorColor: Theme.of(context).primaryColor,
              //         ),
              //         AppLocalizations.of(context)!.translate('global_ok'),
              //             () {print('yes');}));
            }
          }
          //Name is not letters
          else{

            //SnackBar
            SnakBarBuilder.buildAwesomeSnackBar(
                context,
                AppLocalizations.of(context)!.translate('signUp_snackBar_currentName'),
                Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                AwesomeSnackBarType.error);

            // key.currentState!.showSnackBar(
            //     SnakBarBuilder.build(
            //         context,
            //         SelectableText(
            //           AppLocalizations.of(context)!.translate('signUp_snackBar_currentName'),
            //           cursorColor: Theme.of(context).primaryColor,
            //         ),
            //         AppLocalizations.of(context)!.translate('global_ok'),
            //             () {print('yes');}));

          }
        }
        //Password is not strong
        else {

          //SnackBar
          SnakBarBuilder.buildAwesomeSnackBar(
              context,
              AppLocalizations.of(context)!.translate('signUp_snackBar_passwordNotString'),
              Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
              AwesomeSnackBarType.error);


          // key.currentState!.showSnackBar(
          //     SnakBarBuilder.build(
          //         context,
          //         SelectableText(
          //           AppLocalizations.of(context)!.translate('signUp_snackBar_passwordNotString'),
          //           cursorColor: Theme.of(context).primaryColor,
          //         ),
          //         AppLocalizations.of(context)!.translate('global_ok'),
          //             () {print('yes');}));

        }
      }
      //Email is not validate
      else {

        //SnackBar
        SnakBarBuilder.buildAwesomeSnackBar(
            context,
            AppLocalizations.of(context)!.translate('signUp_snackBar_emailNotValidate'),
            Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
            AwesomeSnackBarType.error);


        // key.currentState!.showSnackBar(
        //     SnakBarBuilder.build(
        //         context,
        //         SelectableText(
        //           AppLocalizations.of(context)!.translate('signUp_snackBar_emailNotValidate'),
        //           cursorColor: Theme.of(context).primaryColor,
        //         ),
        //         AppLocalizations.of(context)!.translate('global_ok'),
        //             ()  {print('yes');}));

      }
    }
    //Fields are empty
    else{

      //SnackBar
      SnakBarBuilder.buildAwesomeSnackBar(
          context,
          AppLocalizations.of(context)!.translate('signUp_snackBar_fillFields'),
          Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
          AwesomeSnackBarType.error);


      // key.currentState!.showSnackBar(
      //     SnakBarBuilder.build(
      //         context,
      //         SelectableText(
      //           AppLocalizations.of(context)!.translate('signUp_snackBar_fillFields'),
      //           cursorColor: Theme.of(context).primaryColor,
      //         ),
      //         AppLocalizations.of(context)!.translate('global_ok'),
      //             (){print('yes');}));
    }
  }

  signUpGoogleMobile(BuildContext context, GlobalKey<ScaffoldState> key  , Uint8List pickImage) async {

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
          .then((userCredential) async{

              //Upload Image of user
              firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
                  .ref('users/${Random().nextInt(10000)}.jpg');

              // Upload raw data.
              await ref.putData(pickImage);

              //Get url of signature
              String urlImageUser = await ref.getDownloadURL();





              //Update user's data (Email and password is ok , address isn't needed)
              FirebaseAuth.instance.currentUser!.updateDisplayName('user_${Random().nextInt(10000)}');
              FirebaseAuth.instance.currentUser!.updatePhotoURL(urlImageUser);

              //Can't update phone number because it is difficult to change !!!!!!!!!
              //FirebaseAuth.instance.currentUser!.updatePhoneNumber(phoneNumber ????);




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
      //         () {print('yes');}));
    }
  }

  signUpGoogleWeb(BuildContext context, GlobalKey<ScaffoldState> key  , Uint8List pickImage) async {
    if (await Util.checkInternet()) {
      // Create a new provider
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider
          .addScope('.............................................');
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

      // Once signed in, return the UserCredential
      FirebaseAuth.instance
          .signInWithPopup(googleProvider)
          .then((userCredential) async{



        //Upload Image of user
        firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
            .ref('users/${Random().nextInt(10000)}.jpg');

        // Upload raw data.
        await ref.putData(pickImage);

        //Get url of signature
        String urlImageUser = await ref.getDownloadURL();





        //Update user's data (Email and password is ok , address isn't needed)
        FirebaseAuth.instance.currentUser!.updateDisplayName('user_${Random().nextInt(10000)}');
        FirebaseAuth.instance.currentUser!.updatePhotoURL(urlImageUser);

        //Can't update phone number because it is difficult to change !!!!!!!!!
        //FirebaseAuth.instance.currentUser!.updatePhoneNumber(phoneNumber ????);



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
      //         () {print('yes');}));
    }
  }

  signUpFacebookMobile(BuildContext context, GlobalKey<ScaffoldState> key  , Uint8List pickImage) async {
    if (await Util.checkInternet()) {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential)
          .then((userCredential) async{


            //Upload Image of user
            firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
                .ref('users/${Random().nextInt(10000)}.jpg');

            // Upload raw data.
            await ref.putData(pickImage);

            //Get url of signature
            String urlImageUser = await ref.getDownloadURL();





            //Update user's data (Email and password is ok , address isn't needed)
            FirebaseAuth.instance.currentUser!.updateDisplayName('user_${Random().nextInt(10000)}');
            FirebaseAuth.instance.currentUser!.updatePhotoURL(urlImageUser);

            //Can't update phone number because it is difficult to change !!!!!!!!!
            //FirebaseAuth.instance.currentUser!.updatePhoneNumber(phoneNumber ????);



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
      //         () {print('yes');}));
    }
  }

  signUpFacebookWeb(BuildContext context, GlobalKey<ScaffoldState> key  , Uint8List pickImage) async {
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
          .then((userCredential) async{


              //Upload Image of user
              firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
                  .ref('users/${Random().nextInt(10000)}.jpg');

              // Upload raw data.
              await ref.putData(pickImage);

              //Get url of signature
              String urlImageUser = await ref.getDownloadURL();





              //Update user's data (Email and password is ok , address isn't needed)
              FirebaseAuth.instance.currentUser!.updateDisplayName('user_${Random().nextInt(10000)}');
              FirebaseAuth.instance.currentUser!.updatePhotoURL(urlImageUser);

              //Can't update phone number because it is difficult to change !!!!!!!!!
              //FirebaseAuth.instance.currentUser!.updatePhoneNumber(phoneNumber ????);


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
      //         (){print('yes');}));
    }
  }

  signUpMicrosoftMobile(BuildContext context, GlobalKey<ScaffoldState> key  , Uint8List pickImage) async {
    if (await Util.checkInternet()) {
      FirebaseAuthOAuth().openSignInFlow("microsoft.com", ["email openid"],
          {'tenant': '.....................................'}).then((user) async{

            //Upload Image of user
            firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
                .ref('users/${Random().nextInt(10000)}.jpg');

            // Upload raw data.
            await ref.putData(pickImage);

            //Get url of signature
            String urlImageUser = await ref.getDownloadURL();





            //Update user's data (Email and password is ok , address isn't needed)
            FirebaseAuth.instance.currentUser!.updateDisplayName('user_${Random().nextInt(10000)}');
            FirebaseAuth.instance.currentUser!.updatePhotoURL(urlImageUser);

            //Can't update phone number because it is difficult to change !!!!!!!!!
            //FirebaseAuth.instance.currentUser!.updatePhoneNumber(phoneNumber ????);



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
      //         () {print('yes');}));
    }
  }

  signUpMicrosoftWeb(BuildContext context, GlobalKey<ScaffoldState> key  , Uint8List pickImage) async {

    if (await Util.checkInternet()) {
      FirebaseAuthOAuth().openSignInFlow("microsoft.com", ["email openid"],
          {'tenant': '..............................'}).then((user) async{



        //Upload Image of user
        firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
            .ref('users/${Random().nextInt(10000)}.jpg');

        // Upload raw data.
        await ref.putData(pickImage);

        //Get url of signature
        String urlImageUser = await ref.getDownloadURL();





        //Update user's data (Email and password is ok , address isn't needed)
        FirebaseAuth.instance.currentUser!.updateDisplayName('user_${Random().nextInt(10000)}');
        FirebaseAuth.instance.currentUser!.updatePhotoURL(urlImageUser);

        //Can't update phone number because it is difficult to change !!!!!!!!!
        //FirebaseAuth.instance.currentUser!.updatePhoneNumber(phoneNumber ????);





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
      //         () {print('yes');}));
    }
  }

}