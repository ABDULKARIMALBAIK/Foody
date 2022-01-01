import 'package:flutter/material.dart';
import 'package:foody/model/modelFake/HomeBestMealsModel.dart';
import 'package:foody/repository/fakeData/HomeRepoFake.dart';
import 'package:foody/repository/firebaseData/HomeRepoFirebase.dart';

class HomeViewModel {

  HomeRepoFirebase firebaseRepo = HomeRepoFirebase();
  HomeRepoFake fakeRepo = HomeRepoFake();


  listen(BuildContext context , GlobalKey<ScaffoldState> key) => firebaseRepo.listen(context, key);

  List<HomeBestMealsModel> bestMealsData() => fakeRepo.bestMealsData();

}