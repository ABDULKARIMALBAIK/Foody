import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class AbstractStringValueState extends Equatable{
  final String value;
  AbstractStringValueState(this.value);
}

class StringValueState extends AbstractStringValueState {
  StringValueState(String value) : super(value);

  @override
  // TODO: implement props
  List<Object?> get props => [value];
}