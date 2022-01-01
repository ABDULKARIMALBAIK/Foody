import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_search/mapbox_search.dart' as mapboxSearch;

@immutable
abstract class AbstractCheckoutMapboxPlacesState extends Equatable {

  List<mapboxSearch.MapBoxPlace>? predictions;

  AbstractCheckoutMapboxPlacesState(this.predictions);
}

class CheckoutMapboxPlacesState extends AbstractCheckoutMapboxPlacesState {

  CheckoutMapboxPlacesState(List<mapboxSearch.MapBoxPlace>? predictions) : super(predictions);

  @override
  // TODO: implement props
  List<Object?> get props => [predictions];
}