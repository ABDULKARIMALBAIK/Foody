import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AbstractSignInPasswordState extends Equatable{
  bool isPasswordVisible = false;
  AbstractSignInPasswordState(this.isPasswordVisible);
}


class SignInPasswordState extends AbstractSignInPasswordState{

  SignInPasswordState(bool isPasswordVisible) : super(isPasswordVisible);

  @override
  // TODO: implement props
  List<Object?> get props => [isPasswordVisible];

}