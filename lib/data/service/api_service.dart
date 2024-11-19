import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/api_response_model.dart';

class ApiService {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev';
  static const String imageUrl = 'https://restaurant-api.dicoding.dev/images';

  static const String exceptionMessage =
      'Sorry we\'re having trouble connecting you to our side right now. Please try again later.';

  Future<ApiResponse> getRestaurants() async {
    final response = await http.get(Uri.parse('$baseUrl/list'));
    if (response.statusCode != 200) throw Exception(exceptionMessage);

    return ApiResponse.fromJson(jsonDecode(response.body));
  }

  Future<ApiResponse> getRestaurant(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/detail/$id'));
    if (response.statusCode != 200) throw Exception(exceptionMessage);

    return ApiResponse.fromJson(jsonDecode(response.body));
  }
}
