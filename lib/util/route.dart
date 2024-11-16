import 'package:flutter/widgets.dart';

import '../data/model/restaurant_model.dart';
import '../module/detail/detail_screen.dart';
import '../module/home/home_screen.dart';

enum RouteEnum {
  homeRoute('/home'),
  detailRoute('/detail');

  const RouteEnum(this.name);
  final String name;
}

final routes = {
  RouteEnum.homeRoute.name: (context) => const HomeScreen(),
  RouteEnum.detailRoute.name: (context) => DetailScreen(
      restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant),
};
