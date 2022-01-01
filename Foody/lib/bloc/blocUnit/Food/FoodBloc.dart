import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foody/bloc/state/Food/FoodState.dart';
import 'package:flutter/material.dart';

class FoodBloc extends Cubit<FoodState>{

  FoodBloc(Stream<QuerySnapshot> foodData , String nameCategory) : super(FoodState(foodData , nameCategory));

  void load(foodData) => emit(FoodState(foodData , state.nameCategory));
  void search(foodData) => emit(FoodState(foodData , state.nameCategory));
  void changeName(nameCategory) => emit(FoodState(state.foodData , nameCategory));
}