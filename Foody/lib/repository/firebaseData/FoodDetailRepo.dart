import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foody/localization/app_localizations.dart';
import 'package:foody/widget/SnakBarBuilder.dart';

class FoodDetailRepo {

  Stream<QuerySnapshot> ratingCommentsFood(String foodId){

    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    return _firestore.collection('Comment').where('food_id', isEqualTo: int.parse(foodId)).snapshots();
  }

  Future<void> addRatingComment(BuildContext context , GlobalKey<ScaffoldState> key , String name , String imgUrl , String comment , int rating , int foodId) async{
    FirebaseFirestore.instance.collection('Comment').add(
      {
        'name': name,
        'img': imgUrl,
        'comment': comment,
        'star': rating,
        'food_id': foodId,
      }
    ).then((value){
      print('add rating comment');


      SnakBarBuilder.buildAwesomeSnackBar(
          context,
          AppLocalizations.of(context)!.translate('foodDetail_snackBar_addComment'),
          Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
          AwesomeSnackBarType.success);

      // key.currentState!.showSnackBar(SnakBarBuilder.build(
      //     context,
      //     SelectableText(
      //       AppLocalizations.of(context)!.translate('foodDetail_snackBar_addComment'),
      //       cursorColor: Theme.of(context).primaryColor,
      //     ),
      //     AppLocalizations.of(context)!.translate('global_ok'),
      //         () {print('add to favorite');}));
    })
    .catchError((error) => print("Failed to add Comment collection: ${error.toString()}"));
  }
}