import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:foody/directions/directions_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

@immutable
abstract class AbstractCheckoutMapState extends Equatable {

  Marker origin;
  Marker destination;
  String distance;
  int status;
  Directions directions;
  List<AutocompletePrediction>? predictions;

  AbstractCheckoutMapState(this.origin, this.destination, this.distance , this.status , this.directions , this.predictions);
}

class CheckoutMapState extends AbstractCheckoutMapState {

  CheckoutMapState(Marker origin , Marker destination , String distance , int status , Directions directions , List<AutocompletePrediction>? predictions) : super(origin , destination , distance , status , directions , predictions);

  @override
  // TODO: implement props
  List<Object?> get props => [origin , destination , distance , status , directions , predictions];
}