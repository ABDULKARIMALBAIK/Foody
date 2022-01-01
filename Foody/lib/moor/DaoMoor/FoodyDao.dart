import 'package:foody/moor/databaseMoor/FoodyDatabase.dart';
import 'package:foody/moor/tableMoor/Favorite.dart';
import 'package:foody/moor/tableMoor/FoodTable.dart';
import 'package:moor/moor.dart';

part 'FoodyDao.g.dart';

@UseDao(tables: [Favorites,FoodTables])
class FoodyDao extends DatabaseAccessor<FoodyDatabase> with _$FoodyDaoMixin{

  FoodyDao(FoodyDatabase db) : super(db);

  static FoodyDao instance = FoodyDao(FoodyDatabase());

  static FoodyDao get getInstance => instance;


  //////////////// * Build Queries to favorite  * ////////////////

  //loads all favorite of user
  Future<List<Favorite>> allFavorite(String userId){
    return (select(favorites)..where((fav) => fav.userId.equals(userId))).get();
  }

  // load selected favorite
  Future<Favorite>  selectedFavorite(String userId , int id){
    return (select(favorites)..where((fav) => fav.userId.equals(userId))..where((fav2) => fav2.id.equals(id))).getSingle();
  }


  // Insert favorite
  Future<int> insertFavorite(userId, String foodId, blurhashImg, category_id, code, description, hasDiscount, img, isSale, name, newPrice, oldPrice, star){

    final _insertFav = FavoritesCompanion(
      userId: Value(userId),
      foodId: Value(foodId),
      blurhashImg: Value(blurhashImg),
      category_id: Value(category_id),
      code: Value(code),
      description: Value(description),
      hasDiscount: Value(hasDiscount),
      img: Value(img),
      isSale: Value(isSale),
      name: Value(name),
      newPrice: Value(newPrice),
      oldPrice: Value(oldPrice),
      star: Value(star),
    );

    return into(favorites).insert(_insertFav);

  }


  // Update favorite
  Future<bool> updateFavorite(id , String userId, foodId, blurhashImg, category_id, code, description, hasDiscount, img, isSale, name, newPrice, oldPrice, star){

    final _updatedFav = FavoritesCompanion(
      id: Value(id),
      userId: Value(userId),
      foodId: Value(foodId),
      blurhashImg: Value(blurhashImg),
      category_id: Value(category_id),
      code: Value(code),
      description: Value(description),
      hasDiscount: Value(hasDiscount),
      img: Value(img),
      isSale: Value(isSale),
      name: Value(name),
      newPrice: Value(newPrice),
      oldPrice: Value(oldPrice),
      star: Value(star),
    );

    return update(favorites).replace(_updatedFav);

  }


  // Delete favorite
  Future<int> deleteFavorite(int idFav){
    return (delete(favorites)..where((fav) => fav.id.equals(idFav))).go();
  }

  // Clear Favorite table
  Future<int> clearFavoriteData(){
    return delete(favorites).go();
  }






  //////////////// * Build Queries to Foods  * ////////////////

  //loads all foods of user
  Future<List<FoodTable>> allFoods(String userId) {
    return (select(foodTables)..where((food) => food.userId.equals(userId))).get();
  }

  // load selected food
  Future<FoodTable>  selectedFood(String userId , int id){
    return (select(foodTables)..where((food) => food.userId.equals(userId))..where((food2) => food2.id.equals(id))).getSingle();
  }

  // load selected food by foodId
  Future<FoodTable>  getFoodByFoodId(String userId , String foodId){
    print('padd 3');
    return (select(foodTables)..where((food) => food.userId.equals(userId))..where((food2) => food2.foodId.equals(foodId))).getSingle();
  }

  // Insert food
  Future<int> insertFood(String userId, foodId, blurhashImg, category_id, code, description, hasDiscount, img, isSale, name, newPrice, oldPrice, star , quantity , size , spices){

    final _insertFood = FoodTablesCompanion(
      userId: Value(userId),
      foodId: Value(foodId),
      blurhashImg: Value(blurhashImg),
      category_id: Value(category_id),
      code: Value(code),
      description: Value(description),
      hasDiscount: Value(hasDiscount),
      img: Value(img),
      isSale: Value(isSale),
      name: Value(name),
      newPrice: Value(newPrice),
      oldPrice: Value(oldPrice),
      star: Value(star),
      quantity: Value(quantity),
      size: Value(size),
      spices: Value(spices)
    );

    return into(foodTables).insert(_insertFood);

  }


  // Update food
  Future<bool> updateFood(id , String userId, foodId, blurhashImg, category_id, code, description, hasDiscount, img, isSale, name, newPrice, oldPrice, star , quantity , size , spices){

    final _updatedFood = FoodTablesCompanion(
      id: Value(id),
      userId: Value(userId),
      foodId: Value(foodId),
      blurhashImg: Value(blurhashImg),
      category_id: Value(category_id),
      code: Value(code),
      description: Value(description),
      hasDiscount: Value(hasDiscount),
      img: Value(img),
      isSale: Value(isSale),
      name: Value(name),
      newPrice: Value(newPrice),
      oldPrice: Value(oldPrice),
      star: Value(star),
      quantity: Value(quantity),
      size: Value(size),
      spices: Value(spices)
    );

    return update(foodTables).replace(_updatedFood);

  }


  // Delete food
  Future<int> deleteFood(int idFood){
    return (delete(foodTables)..where((food) => food.id.equals(idFood))).go();
  }

  // Clear Foods table
  Future<int> clearFoodsData(){
    return delete(foodTables).go();
  }


}