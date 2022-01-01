import 'dart:math';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody/localization/app_localizations.dart';
import 'package:foody/moor/databaseMoor/FoodyDatabase.dart';
import 'package:foody/widget/SnakBarBuilder.dart';

class CheckoutRepo {

  Future<bool> checkCoupon(String code) async {

    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    int length = await _firestore.collection('Coupon').where('code' , isEqualTo: code).snapshots().length;

    //The code is right  length > 0
    return length > 0;
  }

  Future<String> uploadSignature(Uint8List signatureBytes) async {

    //start upload to firebase storage
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('signatures/${Random().nextInt(10000)}.png');

    // Upload raw data.
    await ref.putData(signatureBytes);

    //Get url of signature
    return await ref.getDownloadURL();
  }


  Future<void> storeOrderInDatabase(String address , String amount , String code , String date , String email , String phone , String status , String total_price , String transactionID , String user_id , BuildContext context , GlobalKey<ScaffoldState> key , List<FoodTable> recipes , String signatureUrl) async {

    //Save recipes of order
    List<Map<String,dynamic>> recipesMap = [];
    for(FoodTable recipe in recipes){
      recipesMap.add(
        {
          'id' : recipe.foodId,
          'category_id' : recipe.category_id,
          'price' : recipe.newPrice,
          'name' : recipe.name,
          'blurhashImg' : recipe.blurhashImg,
          'img' : recipe.img,
          'code' : recipe.code,
          'size' : recipe.size,
          'spices' : recipe.spices,
          'quantity' : recipe.quantity
        }
      );
    }


    FirebaseFirestore.instance.collection('order').add(
        {
          'address': address,
          'amount': amount,
          'code': code,
          'date': date,
          'email': email,
          'phone': phone,
          'status': status,
          'signature_url' : signatureUrl,
          'total_price': total_price,
          'transactionID': transactionID,
          'user_id': user_id,
          'recipes' : recipesMap
        }
    ).then((value){
      print('add new order');

      SnakBarBuilder.buildAwesomeSnackBar(
          context,
          AppLocalizations.of(context)!.translate('checkout_snackBar_order_sent_success'),
          Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
          AwesomeSnackBarType.success);


      // key.currentState!.showSnackBar(SnakBarBuilder.build(
      //     context,
      //     SelectableText(
      //       AppLocalizations.of(context)!.translate('checkout_snackBar_order_sent_success'),
      //       cursorColor: Theme.of(context).primaryColor,
      //     ),
      //     AppLocalizations.of(context)!.translate('global_ok'),
      //         () {print('add to order table');}));
    })
        .catchError((error) => print("Failed to add order collection: ${error.toString()}"));
  }

}