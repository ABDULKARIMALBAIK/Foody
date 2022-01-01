import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AbstractAnimatedButtonState extends Equatable{
  bool touched;
  AbstractAnimatedButtonState(this.touched);
}

class AnimatedButtonState extends AbstractAnimatedButtonState {
  AnimatedButtonState(bool touched) : super(touched);

  @override
  // TODO: implement props
  List<Object?> get props => [touched];
}