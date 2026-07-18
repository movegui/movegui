import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movegui/models/geo_cordinates_model.dart';
import 'package:movegui/services/api_service.dart';

class AdressService {
  final ApiService api;

  AdressService({required this.api});

  Future<GeoCordinatesModel?> getCoordinates(String address) async {
    final url =
        '${api.env.baseUrl}/movegui-253e0/us-central1/geocodeAddress'
        '?address=${Uri.encodeComponent(address)}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return GeoCordinatesModel(
        longitude: data['longitude'],
        latitude: data['latitude'],
      );
    }

    return null;
  }
}
