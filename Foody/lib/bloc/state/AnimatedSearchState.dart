import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AbstractAnimatedSearchState extends Equatable{
  bool hover;
  bool toggle;
  AbstractAnimatedSearchState(this.toggle,this.hover);
}

class AnimatedSearchState extends AbstractAnimatedSearchState {
  AnimatedSearchState(bool hover , bool toggle) : super(hover,toggle);

  @override
  // TODO: implement props
  List<Object?> get props => [hover,toggle];
}