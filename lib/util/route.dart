import 'package:flutter/widgets.dart';

import '../data/model/restaurant_model.dart';
import '../module/detail/detail_screen.dart';
import '../module/home/home_screen.dart';
import '../module/settings/settings_screen.dart';
import '../module/wishlist/wishlist_screen.dart';

enum RouteEnum {
  home('/home'),
  detail('/detail'),
  settings('/settings'),
  wishlist('/wishlist');

  const RouteEnum(this.name);
  final String name;
}

final routes = {
  RouteEnum.home.name: (context) => const HomeScreen(),
  RouteEnum.detail.name: (context) => DetailScreen(
      restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant),
  RouteEnum.settings.name: (context) => const SettingsScreen(),
  RouteEnum.wishlist.name: (context) => const WishlistScreen(),
};
