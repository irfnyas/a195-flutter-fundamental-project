import 'restaurant_model.dart';

class ApiResponse {
  ApiResponse({
    this.error,
    this.message,
    this.count,
    this.founded,
    this.restaurants,
    this.restaurant,
  });

  final bool? error;
  final String? message;
  final int? count;
  final int? founded;
  final List<Restaurant>? restaurants;
  final Restaurant? restaurant;

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      error: json['error'],
      message: json['message'],
      count: json['count'],
      founded: json['founded'],
      restaurants: json['restaurants'] == null
          ? null
          : Restaurant.fromArray(json['restaurants']),
      restaurant: json['restaurant'] == null
          ? null
          : Restaurant.fromJson(json['restaurant']),
    );
  }
}
