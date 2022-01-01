import 'package:bloc/bloc.dart';
import 'package:foody/bloc/state/Checkout/CheckoutMapboxState.dart';
import 'package:mapbox_search/mapbox_search.dart' as mapboxSearch;


class CheckoutMapboxBloc extends Cubit<CheckoutMapboxState>{

  CheckoutMapboxBloc(mapboxSearch.Location origin , mapboxSearch.Location destination) : super(CheckoutMapboxState(origin , destination));


  void changeDestination(mapboxSearch.Location destination) => emit(CheckoutMapboxState(state.origin , destination));
  void changeOrigin(mapboxSearch.Location origin) => emit(CheckoutMapboxState(origin , state.destination));

}