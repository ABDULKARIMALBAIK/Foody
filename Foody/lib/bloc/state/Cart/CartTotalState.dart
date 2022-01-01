import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AbstractCartTotalState extends Equatable{
  double totalPrice = 0.0;
  double deliverCharge = 0.0;
  double totalSummation = 0.0;

  AbstractCartTotalState(this.totalPrice, this.deliverCharge, this.totalSummation);
}

class CartTotalState extends AbstractCartTotalState{

  CartTotalState(double totalPrice , double deliverCharge , double totalSummation) : super(totalPrice , deliverCharge ,totalSummation);

  @override
  // TODO: implement props
  List<Object?> get props => [totalPrice , deliverCharge , totalSummation];
}