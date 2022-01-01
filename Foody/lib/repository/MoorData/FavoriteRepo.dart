import 'package:foody/moor/DaoMoor/FoodyDao.dart';
import 'package:foody/moor/databaseMoor/FoodyDatabase.dart';

class FavoriteRepo {

  late FoodyDao dao;

  FavoriteRepo(){
    dao = FoodyDao.instance;
  }

  Future<List<Favorite>> allFavorite(String userId) => dao.allFavorite(userId);

  Future<Favorite> selectedFavorite(String userId , int favId) => dao.selectedFavorite(userId , favId);

  Future<int> insertFavorite(userId, foodId, blurhashImg, category_id, code, description, hasDiscount, img, isSale, name, newPrice, oldPrice, star)
  => dao.insertFavorite(userId, foodId, blurhashImg, category_id, code, description, hasDiscount, img, isSale, name, newPrice, oldPrice, star);

  Future<bool> updateFavorite(id , userId, foodId, blurhashImg, category_id, code, description, hasDiscount, img, isSale, name, newPrice, oldPrice, star)
  => dao.updateFavorite(id , userId, foodId, blurhashImg, category_id, code, description, hasDiscount, img, isSale, name, newPrice, oldPrice, star);

  Future<int> deleteFavorite(int idFav) => dao.deleteFavorite(idFav);

}