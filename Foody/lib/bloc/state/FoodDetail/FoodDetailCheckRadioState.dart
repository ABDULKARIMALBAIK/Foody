import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AbstractFoodDetailCheckRadioState extends Equatable{
  int radioCheck;
  AbstractFoodDetailCheckRadioState(this.radioCheck);
}

class FoodDetailCheckRadioState extends AbstractFoodDetailCheckRadioState {
  FoodDetailCheckRadioState(int radioCheck) : super(radioCheck);

  @override
  // TODO: implement props
  List<Object?> get props => [radioCheck];
}