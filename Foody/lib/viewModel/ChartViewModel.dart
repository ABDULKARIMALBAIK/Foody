import 'package:foody/model/modelFake/ChartBestFoodsModel.dart';
import 'package:foody/model/modelFake/ChartDataGridPurchases.dart';
import 'package:foody/model/modelFake/ChartDiscountModel.dart';
import 'package:foody/model/modelFake/ChartForecastingNumOrdersModel.dart';
import 'package:foody/model/modelFake/ChartNumDiscountsFoodsModel.dart';
import 'package:foody/model/modelFake/ChartNumFavEachFoodPerYear.dart';
import 'package:foody/model/modelFake/ChartNumOrderFoodsModel.dart';
import 'package:foody/model/modelFake/ChartPurchasesPerMonthModel.dart';
import 'package:foody/repository/fakeData/ChartRepo.dart';

class ChartViewModel {

  ChartRepo repo = ChartRepo();

  double get getCardPurchases => repo.getCardPurchases;

  double get getCardFavorite => repo.getCardFavorite;

  List<ChartDiscountModel> getCardDiscount() => repo.getCardDiscount();

  List<ChartBestFoodsModel> getCardBestFoods() => repo.getCardBestFoods();

  List<ChartPurchasesPerMonthModel> getPurchasesPerMonth() => repo.getPurchasesPerMonth();

  List<ChartNumOrderFoodsModel> getNumOrderFoods() => repo.getNumOrderFoods();

  List<ChartNumDiscountsFoodsModel> getNumDiscountsFoods() => repo.getNumDiscountsFoods();

  List<ChartForecastingNumOrdersModel> getPredictionNumOrdersFoods() => repo.getPredictionNumOrdersFoods();

  List<List<ChartNumFavEachFoodPerYear>> getNumFavEachFoodYear() => repo.getNumFavEachFoodYear();

  List<List<int>> getBestThreeFoods() => repo.getBestThreeFoods();

  List<ChartDataGridPurchases> getPurchases() => repo.getPurchases();



}