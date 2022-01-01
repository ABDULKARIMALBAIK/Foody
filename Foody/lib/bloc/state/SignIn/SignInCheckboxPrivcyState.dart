import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AbstractSignInCheckboxPrivcyState extends Equatable{
  bool isCheckedPrivcyConditions = false;
  AbstractSignInCheckboxPrivcyState(this.isCheckedPrivcyConditions);
}

class SignInCheckboxPrivcyState extends AbstractSignInCheckboxPrivcyState{

  SignInCheckboxPrivcyState(bool isCheckedPrivcyConditions) : super(isCheckedPrivcyConditions);

  @override
  // TODO: implement props
  List<Object?> get props => [isCheckedPrivcyConditions];
}