import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'directions_model.dart';

class DirectionsRepository {

  static const String _baseUrl = '.......................................................';
  final Dio _dio;

  DirectionsRepository(Dio dio) : _dio = dio;

  Future<Directions> getDirections(LatLng origin, LatLng destination) async {

    print('start get direction');
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': 'AIzaSyCxz8oEwfCr5nTFDoxKwRpn3gOOMto8Qis',
      },
    );
    print('end get direction');


    // Check if response is successful
    if (response.statusCode == 200) {
      print('response is ok 200');
    }

    print('response is not ok 4xx');
    return Directions.fromMap(response.data);
  }
}