import 'package:bloc/bloc.dart';
import 'package:foody/bloc/state/Checkout/CheckoutMapboxPlacesState.dart';
import 'package:mapbox_search/mapbox_search.dart' as mapboxSearch;

class CheckoutMapboxPlacesBloc extends Cubit<CheckoutMapboxPlacesState>{

  CheckoutMapboxPlacesBloc(List<mapboxSearch.MapBoxPlace>? predictions) : super(CheckoutMapboxPlacesState(predictions));


  void changePredications(List<mapboxSearch.MapBoxPlace>? predictions) => emit(CheckoutMapboxPlacesState(predictions));

}