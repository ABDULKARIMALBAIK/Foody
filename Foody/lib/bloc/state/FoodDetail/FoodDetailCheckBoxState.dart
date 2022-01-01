import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AbstractFoodDetailCheckBoxState extends Equatable{
  bool checked;
  AbstractFoodDetailCheckBoxState(this.checked);
}

class FoodDetailCheckBoxState extends AbstractFoodDetailCheckBoxState {
  FoodDetailCheckBoxState(bool checked) : super(checked);

  @override
  // TODO: implement props
  List<Object?> get props => [checked];
}