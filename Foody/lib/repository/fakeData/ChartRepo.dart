import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:foody/model/modelFake/ChartBestFoodsModel.dart';
import 'package:foody/model/modelFake/ChartDataGridPurchases.dart';
import 'package:foody/model/modelFake/ChartDiscountModel.dart';
import 'package:foody/model/modelFake/ChartForecastingNumOrdersModel.dart';
import 'package:foody/model/modelFake/ChartNumDiscountsFoodsModel.dart';
import 'package:foody/model/modelFake/ChartNumFavEachFoodPerYear.dart';
import 'package:foody/model/modelFake/ChartNumOrderFoodsModel.dart';
import 'package:foody/model/modelFake/ChartPurchasesPerMonthModel.dart';
import 'dart:io';

class ChartRepo {

  //Purchases
  double get getCardPurchases => 60;

  //Favorite
  double get getCardFavorite => 35;

  //Discounts
  List<ChartDiscountModel> getCardDiscount(){
    List<ChartDiscountModel> models = [];
    models.add(ChartDiscountModel('September' , 60));
    models.add(ChartDiscountModel('October' , 45));
    models.add(ChartDiscountModel('November' , 80));
    models.add(ChartDiscountModel('December' , 100));

    return models;
  }

  //Best foods
  List<ChartBestFoodsModel> getCardBestFoods(){

    List<ChartBestFoodsModel> models = [];
    models.add(ChartBestFoodsModel('Multigrain Pizza' , 50 , Color.fromARGB(100, 174, 173, 240) , '70%'));
    models.add(ChartBestFoodsModel('Shami Kebab' , 25 , Color.fromARGB(100, 236, 195, 11) , '60%'));
    models.add(ChartBestFoodsModel('Philly Cheesesteak' , 15  ,  Color.fromARGB(100, 243, 119, 72) , '52%'));
    models.add(ChartBestFoodsModel('Meen Curry' , 10 , Color.fromARGB(100, 82, 170, 94) , '40%'));

    return models;
  }

  //Purchases per months
  List<ChartPurchasesPerMonthModel> getPurchasesPerMonth(){

    List<ChartPurchasesPerMonthModel> models = [];
    models.add(ChartPurchasesPerMonthModel(1, 500));
    models.add(ChartPurchasesPerMonthModel(2, 700));
    models.add(ChartPurchasesPerMonthModel(3, 300));
    models.add(ChartPurchasesPerMonthModel(4, 200));
    models.add(ChartPurchasesPerMonthModel(5, 600));
    models.add(ChartPurchasesPerMonthModel(6, 400));
    models.add(ChartPurchasesPerMonthModel(7, 1000));
    models.add(ChartPurchasesPerMonthModel(8, 300));
    models.add(ChartPurchasesPerMonthModel(9, 700));
    models.add(ChartPurchasesPerMonthModel(10, 500));
    models.add(ChartPurchasesPerMonthModel(11, 400));
    models.add(ChartPurchasesPerMonthModel(12, 600));

    return models;

  }
  
  //Num of order per food
  List<ChartNumOrderFoodsModel> getNumOrderFoods(){
    
    List<ChartNumOrderFoodsModel> models = [];
    models.add(ChartNumOrderFoodsModel('Meen Curry' , 30));
    models.add(ChartNumOrderFoodsModel('Hariyali Machli' , 50));
    models.add(ChartNumOrderFoodsModel('Fish Duglere' , 20));
    models.add(ChartNumOrderFoodsModel('Cajun Spiced' , 10));
    models.add(ChartNumOrderFoodsModel('Shami Kebab' , 40));
    models.add(ChartNumOrderFoodsModel('Multigrain Pizza' , 30));
    models.add(ChartNumOrderFoodsModel('Chicken Pizza' , 80));
    models.add(ChartNumOrderFoodsModel('Double Burger' , 100));
    models.add(ChartNumOrderFoodsModel('Luger Burger' , 20));
    models.add(ChartNumOrderFoodsModel('Kadhai Chicken' , 50));

    return models;

  }


  //Num of discounts per food
  List<ChartNumDiscountsFoodsModel> getNumDiscountsFoods(){

    List<ChartNumDiscountsFoodsModel> models = [];
    models.add(ChartNumDiscountsFoodsModel('Meen Curry' , 20));
    models.add(ChartNumDiscountsFoodsModel('Hariyali Machli' , 80));
    models.add(ChartNumDiscountsFoodsModel('Fish Duglere' , 60));
    models.add(ChartNumDiscountsFoodsModel('Cajun Spiced' , 10));
    models.add(ChartNumDiscountsFoodsModel('Shami Kebab' , 20));
    models.add(ChartNumDiscountsFoodsModel('Multigrain Pizza' , 70));
    models.add(ChartNumDiscountsFoodsModel('Chicken Pizza' , 50));
    models.add(ChartNumDiscountsFoodsModel('Double Burger' , 60));
    models.add(ChartNumDiscountsFoodsModel('Luger Burger' , 40));
    models.add(ChartNumDiscountsFoodsModel('Kadhai Chicken' , 70));

    return models;

  }


  //Forecasting num of orders per food
  List<ChartForecastingNumOrdersModel> getPredictionNumOrdersFoods(){

    List<ChartForecastingNumOrdersModel> models = [];
    models.add(ChartForecastingNumOrdersModel('January', 10 , 30));
    models.add(ChartForecastingNumOrdersModel('February', 50 , 70));
    models.add(ChartForecastingNumOrdersModel('March', 20 , 60));
    models.add(ChartForecastingNumOrdersModel('April', 30 , 70));
    models.add(ChartForecastingNumOrdersModel('May', 80 , 90));
    models.add(ChartForecastingNumOrdersModel('June', 40 , 50));
    models.add(ChartForecastingNumOrdersModel('July', 20 , 80));
    models.add(ChartForecastingNumOrdersModel('August', 60 , 90));
    models.add(ChartForecastingNumOrdersModel('September', 80 , 100));
    models.add(ChartForecastingNumOrdersModel('October', 50 , 70));
    models.add(ChartForecastingNumOrdersModel('November', 40 , 80));
    models.add(ChartForecastingNumOrdersModel('December', 30 , 60));

    return models;

  }


  //Num of favorites for each food per year
  List<List<ChartNumFavEachFoodPerYear>> getNumFavEachFoodYear(){

    List<List<ChartNumFavEachFoodPerYear>> models = [];

    //Masaledar Chicken Food
    List<ChartNumFavEachFoodPerYear> firstFood = [];
    firstFood.add(ChartNumFavEachFoodPerYear('Masaledar Chicken' , '2015' , 10));
    firstFood.add(ChartNumFavEachFoodPerYear('Masaledar Chicken' , '2016' , 30));
    firstFood.add(ChartNumFavEachFoodPerYear('Masaledar Chicken' , '2017' , 20));
    firstFood.add(ChartNumFavEachFoodPerYear('Masaledar Chicken', '2018' , 60));
    firstFood.add(ChartNumFavEachFoodPerYear('Masaledar Chicken' , '2019' , 70));
    firstFood.add(ChartNumFavEachFoodPerYear('Masaledar Chicken' , '2020' , 40));
    firstFood.add(ChartNumFavEachFoodPerYear('Masaledar Chicken' , '2021' , 50));
    models.add(firstFood);

    //Masaledar Chicken Food
    List<ChartNumFavEachFoodPerYear> secondFood = [];
    secondFood.add(ChartNumFavEachFoodPerYear('Fish Duglere' , '2015' , 20));
    secondFood.add(ChartNumFavEachFoodPerYear('Fish Duglere' , '2016' , 10));
    secondFood.add(ChartNumFavEachFoodPerYear('Fish Duglere' , '2017' , 40));
    secondFood.add(ChartNumFavEachFoodPerYear('Fish Duglere', '2018' , 50));
    secondFood.add(ChartNumFavEachFoodPerYear('Fish Duglere' , '2019' , 100));
    secondFood.add(ChartNumFavEachFoodPerYear('Fish Duglere' , '2020' , 80));
    secondFood.add(ChartNumFavEachFoodPerYear('Fish Duglere' , '2021' , 90));
    models.add(secondFood);

    //Le Pigeon Burger Food
    List<ChartNumFavEachFoodPerYear> thirdFood = [];
    thirdFood.add(ChartNumFavEachFoodPerYear('Le Pigeon Burger' , '2015' , 50));
    thirdFood.add(ChartNumFavEachFoodPerYear('Le Pigeon Burger' , '2016' , 20));
    thirdFood.add(ChartNumFavEachFoodPerYear('Le Pigeon Burger' , '2017' , 80));
    thirdFood.add(ChartNumFavEachFoodPerYear('Le Pigeon Burger', '2018' , 90));
    thirdFood.add(ChartNumFavEachFoodPerYear('Le Pigeon Burger' , '2019' , 70));
    thirdFood.add(ChartNumFavEachFoodPerYear('Le Pigeon Burger' , '2020' , 50));
    thirdFood.add(ChartNumFavEachFoodPerYear('Le Pigeon Burger' , '2021' , 100));
    models.add(thirdFood);

    return models;
  }


  //Best three foods
  List<List<int>> getBestThreeFoods(){

    List<List<int>> models = [];

    //First Food
    List<int> firstFood = [];
    firstFood.add(25);
    firstFood.add(10);
    firstFood.add(35);
    models.add(firstFood);

    //Second Food
    List<int> secondFood = [];
    secondFood.add(15);
    secondFood.add(30);
    secondFood.add(20);
    models.add(secondFood);

    //Third Food
    List<int> thirdFood = [];
    thirdFood.add(40);
    thirdFood.add(20);
    thirdFood.add(10);
    models.add(thirdFood);


    return models;
  }


  //DataGrid Purchases
  List<ChartDataGridPurchases> getPurchases(){

    return [
      ChartDataGridPurchases(1 , 'Kebab Pizza' , 10 , 320 , 100),
      ChartDataGridPurchases(2 , 'Mexican Pizza' , 21 , 1050 , 130),
      ChartDataGridPurchases(3 , 'Pepsi' , 5 , 70 , 30),
      ChartDataGridPurchases(4 , 'Cocktail Juice' , 14 , 800 , 0),
      ChartDataGridPurchases(5 , 'Strawberry Juice' , 10 , 320 , 20),
      ChartDataGridPurchases(6 , 'Butter Chicken' , 3 , 500 , 0),
      ChartDataGridPurchases(7 , 'Masala Fried' , 7 , 1200 , 90),
      ChartDataGridPurchases(8 , 'Kadhai Chicken' , 18 , 900 , 0),
      ChartDataGridPurchases(9 , 'Lolly Burger' , 6 , 300 , 0),
      ChartDataGridPurchases(10 , 'Luger Burger' , 1 , 100 , 0),
      ChartDataGridPurchases(11 , 'Kadhai Chicken' , 8 , 600 , 90),
      ChartDataGridPurchases(12 , 'Meen Curry' , 20 , 1000 , 50),
      ChartDataGridPurchases(13 , 'Scone Pizza' , 15 , 1500 , 150),
    ];

  }


}