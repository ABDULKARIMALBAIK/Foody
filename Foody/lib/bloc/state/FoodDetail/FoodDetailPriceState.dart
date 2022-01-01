import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AbstractFoodDetailPriceState extends Equatable{
  double price;
  AbstractFoodDetailPriceState(this.price);
}

class FoodDetailPriceState extends AbstractFoodDetailPriceState {
  FoodDetailPriceState(double price) : super(price);

  @override
  // TODO: implement props
  List<Object?> get props => [price];
}