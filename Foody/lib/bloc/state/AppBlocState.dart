import 'package:flutter/material.dart';
import 'package:foody/model/modelApp/AppModel.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class AbstractAppBlocState extends Equatable{
  final AppModel appModel;
  AbstractAppBlocState(this.appModel);
}

class AppBlocState extends AbstractAppBlocState {
  AppBlocState(AppModel appModel) : super(appModel);

  @override
  // TODO: implement props
  List<Object?> get props => [appModel];
}