import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:foody/repository/firebaseData/SignUpRepo.dart';

class SignUpViewModel{

  SignUpRepo repo = SignUpRepo();

  signUp(BuildContext context , GlobalKey<ScaffoldState> key , String email , String password , String name , String phone , String address , bool isChecked , Uint8List pickImage) => repo.signUp(context, key , email , password , name , phone , address , isChecked , pickImage);

  signUpGoogleMobile(BuildContext context, GlobalKey<ScaffoldState> key , Uint8List pickImage) => repo.signUpGoogleMobile(context, key, pickImage);
  signUpGoogleWeb(BuildContext context, GlobalKey<ScaffoldState> key , Uint8List pickImage)  => repo.signUpGoogleWeb(context, key, pickImage);

  signUpFacebookMobile(BuildContext context, GlobalKey<ScaffoldState> key , Uint8List pickImage) => repo.signUpFacebookMobile(context, key, pickImage);
  signUpFacebookWeb(BuildContext context, GlobalKey<ScaffoldState> key , Uint8List pickImage) => repo.signUpFacebookWeb(context, key, pickImage);

  signUpMicrosoftMobile(BuildContext context, GlobalKey<ScaffoldState> key , Uint8List pickImage) => repo.signUpMicrosoftMobile(context, key, pickImage);
  signUpMicrosoftWeb(BuildContext context, GlobalKey<ScaffoldState> key , Uint8List pickImage) => repo.signUpMicrosoftWeb(context, key, pickImage);

}