// import 'dart:io';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';

class Util {
  static String generateStrongPassword(){

    final length = 20;
    final lettersLowerCase = "abcdefghijklmnopqrstuvwxyz";
    final lettersUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    final number = "0123456789";
    final special = "!@#\$%^&*(),.?:{}[]|<>";

    String chars = '';
    chars += '$lettersLowerCase$lettersUpperCase';
    chars += '$number';
    chars += '$special';

    return List.generate(length, (index){

      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];

    }).join('');
  }

  static Future<bool> checkInternet() async{

    print('Start check internet connection');

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile) {
      //online
      print('Online');
      return true;
    }
    else {
      //Offline  (none , Ethernet)
      print('Offline');
      return false;
    }
    //////////////////////////////// * Old Code doesn't support web * ///////////////////////////////
    // try {
    //   print('passed here');
    //   final result = await InternetAddress.lookup('google.com');
    //
    //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    //     print('connected');
    //     return true;
    //   }
    //   else{
    //     return false;
    //   }
    // } on SocketException catch (e) {
    //   print('not connected' + e.message);
    //   return false;
    // }

  }

  static bool validateEmail(String email){
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    return emailValid;
  }

  static bool strongPassword(String password){
    if(
    (password.contains(RegExp(r"[a-z]")) || password.contains(RegExp(r"[A-Z]"))) &&
        password.contains(RegExp(r"[0-9]")) &&
        password.contains(RegExp(r'[!@#\$%^&*(),.?:{}[]|<>]')) &&
        password.length >= 8){
      return true;
    }
    else
      return false;
  }

  static bool validPhoneNumber(String phoneNumber) {
    // Null or empty string is invalid phone number
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return false;
    }

    // You may need to change this pattern to fit your requirement.
    // I just copied the pattern from here: https://regexr.com/3c53v
    const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(phoneNumber)) {
      return false;
    }
    return true;
  }

}