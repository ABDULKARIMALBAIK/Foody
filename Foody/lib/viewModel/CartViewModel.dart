import 'package:foody/moor/databaseMoor/FoodyDatabase.dart';
import 'package:foody/repository/MoorData/FoodCartRepo.dart';

class CartViewModel {
  FoodCartRepo cartRepo = FoodCartRepo();

  Future<List<FoodTable>> allFoods(String userId) => cartRepo.allFoods(userId);

  Future<bool> changeQuantity(int id , String userId, String foodId, String blurhashImg, String category_id, String code, String description, String hasDiscount, String img, String isSale, String name, String newPrice, String oldPrice, String star , int quantity, int size , String spices)
      => cartRepo.updateFood(id , userId, foodId, blurhashImg, category_id, code, description, hasDiscount, img, isSale, name, newPrice, oldPrice, star , quantity, size , spices);


  Future<int> deleteFood(int idFood) => cartRepo.deleteFood(idFood);


  Future<int> insertFood(String userId, String foodId, String blurhashImg, String category_id, String code, String description, String hasDiscount, String img, String isSale, String name, String newPrice, String oldPrice, String star , int quantity, int size , String spices)
  => cartRepo.insertFood(userId, foodId, blurhashImg, category_id, code, description, hasDiscount, img, isSale, name, newPrice, oldPrice, star , quantity, size , spices);

}