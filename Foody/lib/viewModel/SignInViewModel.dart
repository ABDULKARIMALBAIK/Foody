import 'package:flutter/material.dart';
import 'package:foody/repository/firebaseData/SignInRepo.dart';

class SignInViewModel {

  SignInRepo repo = SignInRepo();

  signIn(BuildContext context , GlobalKey<ScaffoldState> key , String email , String password , bool isChecked) => repo.signIn(context, key , email , password , isChecked);

  signInGoogleMobile(BuildContext context, GlobalKey<ScaffoldState> key) => repo.signInGoogleMobile(context, key);
  signInGoogleWeb(BuildContext context, GlobalKey<ScaffoldState> key) => repo.signInGoogleWeb(context, key);

  signInFacebookMobile(BuildContext context, GlobalKey<ScaffoldState> key) => repo.signInFacebookMobile(context, key);
  signInFacebookWeb(BuildContext context, GlobalKey<ScaffoldState> key) => repo.signInFacebookWeb(context, key);

  signInMicrosoftMobile(BuildContext context, GlobalKey<ScaffoldState> key) => repo.signInMicrosoftMobile(context, key);
  signInMicrosoftWeb(BuildContext context, GlobalKey<ScaffoldState> key) => repo.signInMicrosoftWeb(context, key);
}