import 'package:bloc/bloc.dart';
import 'package:foody/bloc/state/Checkout/CheckoutMapState.dart';
import 'package:foody/directions/directions_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

class CheckoutMapBloc extends Cubit<CheckoutMapState>{

  CheckoutMapBloc(Marker origin , Marker destination , String distance , int status , Directions directions , List<AutocompletePrediction>? predictions) : super(CheckoutMapState(origin , destination , distance , status , directions , predictions));


  void changeDestination(Marker destination , Directions directions , String distance) => emit(CheckoutMapState(state.origin , destination , distance  ,state.status , directions , state.predictions));
  void changeOrigin(Marker origin , Directions directions , String distance) => emit(CheckoutMapState(origin , state.destination , distance  ,state.status , directions , state.predictions));
  void changePredictions(List<AutocompletePrediction>? predictions) => emit(CheckoutMapState(state.origin , state.destination , state.distance  ,state.status , state.directions , predictions));

}