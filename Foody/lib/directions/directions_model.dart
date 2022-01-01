import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions {
  late LatLngBounds bounds;
  late List<PointLatLng> polylinePoints;
  late String totalDistance;
  late String totalDuration;

  Directions(
      this.bounds,
      this.polylinePoints,
      this.totalDistance,
      this.totalDuration,
      );

  factory Directions.fromMap(Map<String, dynamic> map) {

    LatLngBounds bounds;
    String distance = '';
    String duration = '';


    // Check if route is not available
    if ((map['routes'] as List).isEmpty){

      print('Create mock directions');
      //Random locations
      bounds = LatLngBounds(
        northeast: LatLng(52.355965 , 4.895361),  //Destination
        southwest: LatLng(52.353820 , 4.893673),  //Origin
      );

      return Directions(
        bounds,
        [],
        distance,
        duration,
      );
    }

    // Get route information
    final data = Map<String, dynamic>.from(map['routes'][0]);

    // Bounds
    final northeast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];

    print('Test northeast : ${data['bounds']['northeast']}');
    print('Test southwest : ${data['bounds']['southwest']}');
    bounds = LatLngBounds(
      northeast: LatLng(northeast['lat'], northeast['lng']),
      southwest: LatLng(southwest['lat'], southwest['lng']),
    );


    // Distance & Duration
    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance']['text'];
      duration = leg['duration']['text'];

      print('Test distance : ${leg['distance']['text']}');
      print('Test distance : ${leg['duration']['text']}');
    }

    print('Test finish making directions : ${PolylinePoints().decodePolyline(data['overview_polyline']['points'])}');

    return Directions(
      bounds,
      PolylinePoints().decodePolyline(data['overview_polyline']['points']),
      distance,
      duration,
    );
  }
}