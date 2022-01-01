import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SnakBarBuilder {

  static SnackBar build(BuildContext context, Widget content, String label , GestureTapCallback onPress) {
    return SnackBar(
      content: content,
      backgroundColor: Color(0xFF151515),
      elevation: 15,
      margin: EdgeInsets.all(12),
      duration: Duration(seconds: 4),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        onPressed: onPress,
        label: label,
        textColor: Colors.yellowAccent,
      ),
    );
  }


  static void buildAwesomeSnackBar(BuildContext context , String label , TextStyle textStyle , AwesomeSnackBarType type){

    switch(type){

      case AwesomeSnackBarType.success :{
        showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: label,
              textStyle: textStyle,
              // backgroundColor: ,
              // icon: ,
              // iconRotationAngle: ,
            )
        );
        break;
      }

      case AwesomeSnackBarType.error :{
        showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: label,
              textStyle: textStyle,
              // backgroundColor: ,
              // icon: ,
              // iconRotationAngle: ,
            )
        );
        break;
      }

      case AwesomeSnackBarType.info :{
        showTopSnackBar(
            context,
            CustomSnackBar.info(
              message: label,
              textStyle: textStyle,
              // backgroundColor: ,
              // icon: ,
              // iconRotationAngle: ,
            )
        );
        break;
      }

      default: {
        showTopSnackBar(
            context,
            CustomSnackBar.info(
              message: label,
              textStyle: textStyle,
              // backgroundColor: ,
              // icon: ,
              // iconRotationAngle: ,
            )
        );
        break;
      }
    }


  }


}

enum AwesomeSnackBarType {
  error,
  success,
  info
}