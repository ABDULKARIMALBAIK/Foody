import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_search/mapbox_search.dart' as mapboxSearch;

@immutable
abstract class AbstractCheckoutMapboxState extends Equatable {

  mapboxSearch.Location origin;
  mapboxSearch.Location destination;

  AbstractCheckoutMapboxState(this.origin, this.destination);
}

class CheckoutMapboxState extends AbstractCheckoutMapboxState {

  CheckoutMapboxState(mapboxSearch.Location origin , mapboxSearch.Location destination) : super(origin , destination);

  @override
  // TODO: implement props
  List<Object?> get props => [origin , destination];
}