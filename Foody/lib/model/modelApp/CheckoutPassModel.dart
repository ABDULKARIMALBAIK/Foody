import 'package:foody/moor/databaseMoor/FoodyDatabase.dart';

class CheckoutPassModel {

  List<FoodTable> carts;
  int totalItems;
  double totalPrice;
  String sizesItems;

  CheckoutPassModel(
      this.carts, this.totalItems, this.totalPrice, this.sizesItems);
}