import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AbstractStrongPasswordState extends Equatable{

  int setperValue;
  String typeName;
  Color colorName;
  bool isPasswordVisible = false;

  AbstractStrongPasswordState(this.setperValue,this.typeName,this.colorName,this.isPasswordVisible);
}

class StrongPasswordState extends AbstractStrongPasswordState {
  StrongPasswordState(int setperValue , String typeName, Color colorName , bool isPasswordVisible) : super(setperValue,typeName,colorName,isPasswordVisible);

  @override
  // TODO: implement props
  List<Object?> get props => [setperValue,typeName,isPasswordVisible,colorName];
}