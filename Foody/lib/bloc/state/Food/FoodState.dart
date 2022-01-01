import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AbstractFoodState extends Equatable{
  Stream<QuerySnapshot> foodData;
  String nameCategory;
  AbstractFoodState(this.foodData , this.nameCategory);
}

class FoodState extends AbstractFoodState{

  FoodState(Stream<QuerySnapshot> foodData , String nameCategory) : super(foodData , nameCategory);

  @override
  // TODO: implement props
  List<Object?> get props => [foodData , nameCategory];
}