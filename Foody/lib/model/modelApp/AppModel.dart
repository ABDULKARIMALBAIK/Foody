import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class AbstractAppModel extends Equatable{
  final Locale locale;
  final ThemeData themeData;
  AbstractAppModel(this.locale,this.themeData);
}

class AppModel extends AbstractAppModel {
  AppModel(Locale locale, ThemeData themeData) : super(locale,themeData);

  @override
  // TODO: implement props
  List<Object?> get props => [locale,themeData];
}
