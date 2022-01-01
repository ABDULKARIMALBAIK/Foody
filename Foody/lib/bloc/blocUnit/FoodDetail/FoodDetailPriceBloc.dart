import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody/bloc/state/FoodDetail/FoodDetailPriceState.dart';

class FoodDetailPriceBloc extends Cubit<FoodDetailPriceState>{

  FoodDetailPriceBloc(double price) : super(FoodDetailPriceState(price));

  void change(double newPrice) => emit(FoodDetailPriceState(newPrice));
}