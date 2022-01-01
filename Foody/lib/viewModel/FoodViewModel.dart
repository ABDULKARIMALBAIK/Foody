import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foody/repository/firebaseData/FoodsRepo.dart';

class FoodViewModel {

  FoodsRepo _foodsRepo = FoodsRepo();

  Stream<QuerySnapshot> categories() => _foodsRepo.categories();

  Stream<QuerySnapshot> bannerData() => _foodsRepo.bannerData();

  Stream<QuerySnapshot> foods(int foodType) => _foodsRepo.foods(foodType);

  Stream<QuerySnapshot> searchFoods(String foodName) => _foodsRepo.searchFoods(foodName);
}