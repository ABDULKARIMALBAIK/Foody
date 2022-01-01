import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody/bloc/state/SignUp/StrongPasswordState.dart';

class StrongPasswordBloc extends Cubit<StrongPasswordState> {

  StrongPasswordBloc() : super(StrongPasswordState(0, 'Empty',Colors.red,false));

  void updateStepValue(int setperValue) => emit(StrongPasswordState(setperValue , state.typeName , state.colorName , state.isPasswordVisible));
  void updateTypeName(String typeName) => emit(StrongPasswordState(state.setperValue , typeName, state.colorName , state.isPasswordVisible));
  void updateColorName(Color colorName) => emit(StrongPasswordState(state.setperValue , state.typeName, colorName , state.isPasswordVisible));
  void updateIsVisible(bool isVisible) => emit(StrongPasswordState(state.setperValue , state.typeName, state.colorName , isVisible));

}