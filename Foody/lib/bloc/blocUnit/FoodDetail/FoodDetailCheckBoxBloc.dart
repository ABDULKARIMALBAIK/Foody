import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody/bloc/state/FoodDetail/FoodDetailCheckBoxState.dart';

class FoodDetailCheckBoxBloc extends Cubit<FoodDetailCheckBoxState>{

  FoodDetailCheckBoxBloc() : super(FoodDetailCheckBoxState(false));

  void change(bool newState) => emit(FoodDetailCheckBoxState(newState));
}