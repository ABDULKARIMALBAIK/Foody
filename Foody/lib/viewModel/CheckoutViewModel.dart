import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:foody/moor/databaseMoor/FoodyDatabase.dart';
import 'package:foody/repository/MoorData/FoodCartRepo.dart';
import 'package:foody/repository/firebaseData/CheckoutRepo.dart';

class CheckoutViewModel {

  CheckoutRepo repo = CheckoutRepo();
  FoodCartRepo cartRepo = FoodCartRepo();

  Future<int> clearCart() => cartRepo.clearFoods();


  Future<bool> checkCoupon(String code) => repo.checkCoupon(code);

  Future<String> uploadSignature(Uint8List signatureBytes) => repo.uploadSignature(signatureBytes);

  Future<void> storeOrderInDatabase(String address , String amount , String code , String date , String email , String phone , String status , String total_price , String transactionID , String user_id , BuildContext context , GlobalKey<ScaffoldState> key , List<FoodTable> recipes , String signatureUrl) => repo.storeOrderInDatabase(address, amount, code, date, email, phone, status, total_price, transactionID, user_id, context, key, recipes, signatureUrl);

}