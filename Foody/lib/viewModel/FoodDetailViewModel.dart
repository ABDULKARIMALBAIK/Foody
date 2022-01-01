import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody/model/modelFake/Spice.dart';
import 'package:foody/moor/databaseMoor/FoodyDatabase.dart';
import 'package:foody/repository/MoorData/FavoriteRepo.dart';
import 'package:foody/repository/MoorData/FoodCartRepo.dart';
import 'package:foody/repository/fakeData/FoodDetailRepoFake.dart';
import 'package:foody/repository/firebaseData/FoodDetailRepo.dart';

class FoodDetailViewModel {

  FoodDetailRepoFake repoFake = FoodDetailRepoFake();
  FoodDetailRepo repo = FoodDetailRepo();
  FoodCartRepo cartRepo = FoodCartRepo();
  FavoriteRepo favRepo = FavoriteRepo();


  List<Spice> getSpices() => repoFake.getSpices();



  Stream<QuerySnapshot> ratingCommentsFood(String foodId) => repo.ratingCommentsFood(foodId);



  Future<int> insertFood(String userId, String foodId, String blurhashImg, String category_id, String code, String description, String hasDiscount, String img, String isSale, String name, String newPrice, String oldPrice, String star , int quantity , int size , String spices)
      => cartRepo.insertFood(userId, foodId, blurhashImg, category_id, code, description, hasDiscount, img, isSale, name, newPrice, oldPrice, star , quantity, size , spices);

  Future<bool> updateFood(int id ,String userId, String foodId, String blurhashImg, String category_id, String code, String description, String hasDiscount, String img, String isSale, String name, String newPrice, String oldPrice, String star , int quantity, int size , String spices)
      => cartRepo.updateFood(id , userId, foodId, blurhashImg, category_id, code, description, hasDiscount, img, isSale, name, newPrice, oldPrice, star , quantity, size , spices);

  Future<FoodTable> selectedFood(String userId , int id) => cartRepo.selectedFood(userId, id);

  Future<FoodTable> getFoodByFoodId(String userId , String foodId){
    return cartRepo.getFoodByFoodId(userId, foodId);
  }

  Future<int> insertFavorite(String userId, String foodId, String blurhashImg, String category_id, String code, String description, String hasDiscount, String img, String isSale, String name, String newPrice, String oldPrice, String star )
      => favRepo.insertFavorite(userId, foodId, blurhashImg, category_id, code, description, hasDiscount, img, isSale, name, newPrice, oldPrice, star);


  Future<void> addRatingComment(BuildContext context , GlobalKey<ScaffoldState> key , String name , String imgUrl , String comment , int rating , int foodId) => repo.addRatingComment(context , key, name, imgUrl, comment, rating, foodId);

}