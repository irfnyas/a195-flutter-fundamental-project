class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
    this.address,
    this.categories,
    this.menus,
    this.reviews,
  });

  final String? id;
  final String? name;
  final String? description;
  final String? pictureId;
  final String? city;
  final num? rating;
  final String? address;
  final List<({String? name})>? categories;
  final ({
    List<({String? name})>? foods,
    List<({String? name})>? drinks
  })? menus;
  final List<({String? name, String? review, String? date})>? reviews;

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['restaurantId'] ?? json['id'],
      name: json['name'],
      description: json['description'],
      pictureId: json['pictureId'],
      city: json['city'],
      rating: json['rating'],
      address: json['address'],
      categories: json['categories'] is! List
          ? null
          : (json['categories'] as List)
              .map((category) => (name: '${category?['name']}'))
              .toList(),
      menus: json['menus'] is! Map
          ? null
          : (
              foods: (json['menus']?['foods'] as List)
                  .map((food) => (name: '${food?['name']}'))
                  .toList(),
              drinks: (json['menus']?['drinks'] as List)
                  .map((drink) => (name: '${drink?['name']}'))
                  .toList(),
            ),
      reviews: json['customerReviews'] is! List
          ? null
          : (json['customerReviews'] as List)
              .map((review) => (
                    name: '${review?['name']}',
                    review: '${review?['review']}',
                    date: '${review?['date']}',
                  ))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'restaurantId': id,
      'name': name,
      'pictureId': pictureId,
      'city': city,
      'rating': rating,
    };
  }

  static List<Restaurant> fromArray(List? json) =>
      List.from((json ?? []).map((data) => Restaurant.fromJson(data)));
}
