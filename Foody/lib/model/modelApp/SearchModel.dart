import 'package:foody/bloc/state/Checkout/CheckoutMapboxPlacesState.dart';
import 'package:mapbox_search/mapbox_search.dart' as mapboxSearch;

class SearchModel {

  List<mapboxSearch.MapBoxPlace>? predictions;

  void changePredications(List<mapboxSearch.MapBoxPlace>? predictions) => this.predictions = predictions;
}