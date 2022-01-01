import 'package:bloc/bloc.dart';
import 'package:foody/bloc/state/Cart/CartTotalState.dart';

class CartTotalBloc extends Cubit<CartTotalState>{

  CartTotalBloc() : super(CartTotalState(0.0 , 0.0 , 0.0));

  void change(double totalPrice , double deliverCharge , double totalSummation) => emit(CartTotalState(totalPrice , deliverCharge ,totalSummation));

}