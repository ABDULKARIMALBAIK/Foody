import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody/bloc/state/FoodDetail/FoodDetailCheckRadioState.dart';

class FoodDetailCheckRadioBloc extends Cubit<FoodDetailCheckRadioState>{

  FoodDetailCheckRadioBloc() : super(FoodDetailCheckRadioState(1));

  void change(int newState) => emit(FoodDetailCheckRadioState(newState));
}