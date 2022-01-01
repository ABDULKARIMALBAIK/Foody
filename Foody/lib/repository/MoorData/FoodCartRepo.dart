import 'package:foody/moor/DaoMoor/FoodyDao.dart';
import 'package:foody/moor/databaseMoor/FoodyDatabase.dart';

class FoodCartRepo {

  late FoodyDao dao;

  FoodCartRepo(){
    dao = FoodyDao.instance;
  }



  Future<List<FoodTable>> allFoods(String userId) => dao.allFoods(userId);

  Future<FoodTable> selectedFood(String userId , int id) => dao.selectedFood(userId , id);

  Future<FoodTable> getFoodByFoodId(String userId , String foodId){
    return dao.getFoodByFoodId(userId , foodId);
  }

  Future<int> insertFood(userId, foodId, blurhashImg, category_id, code, description, hasDiscount, img, isSale, name, newPrice, oldPrice, star , quantity , size , spices)
      => dao.insertFood(userId, foodId, blurhashImg, category_id, code, description, hasDiscount, img, isSale, name, newPrice, oldPrice, star , quantity, size , spices);

  Future<bool> updateFood(id ,userId, foodId, blurhashImg, category_id, code, description, hasDiscount, img, isSale, name, newPrice, oldPrice, star , quantity, size , spices)
      => dao.updateFood(id , userId, foodId, blurhashImg, category_id, code, description, hasDiscount, img, isSale, name, newPrice, oldPrice, star , quantity, size , spices);

  Future<int> deleteFood(int idFood) => dao.deleteFood(idFood);

  Future<int> clearFoods() => dao.clearFoodsData();

}