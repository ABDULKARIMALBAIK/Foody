import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show Locale, ThemeData;
import 'package:foody/bloc/state/AppBlocState.dart';
import 'package:foody/model/modelApp/AppModel.dart';
import 'package:foody/style/theme/ThemeAppGenerator.dart';

class AppBloc extends Cubit<AppBlocState> {

  AppBloc(ThemeData theme , Locale language ) : super(AppBlocState(AppModel(language, theme)));

  void toArabic() => emit(AppBlocState(AppModel(Locale('ar'),state.appModel.themeData)));
  void toEnglish() => emit(AppBlocState(AppModel(Locale('en'),state.appModel.themeData)));

  void toLight() => emit(AppBlocState(AppModel(state.appModel.locale,ThemeAppGenerator.lightTheme)));
  void toDark() => emit(AppBlocState(AppModel(state.appModel.locale,ThemeAppGenerator.darkTheme)));
}