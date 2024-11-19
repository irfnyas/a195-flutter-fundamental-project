import 'package:flutter/widgets.dart';

import '../../data/model/restaurant_model.dart';
import '../../data/service/sqlite_service.dart';
import '../../util/modal.dart';
import '../../util/route.dart';
import '../../util/view_result_state.dart';

class WishlistProvider extends ChangeNotifier {
  ViewResultState _resultState = ViewNoneState();
  ViewResultState get resultState => _resultState;
  set resultState(ViewResultState value) {
    _resultState = value;
    notifyListeners();
  }

  Future<void> fetchData() async {
    try {
      final result = await SqliteService.getAllItems();
      resultState = result.isEmpty
          ? ViewNoneState()
          : ViewLoadedState(restaurants: result);
    } on Exception catch (_) {
      resultState = ViewErrorState(
          'Sorry, something is wrong when fetching your wishlist.');
    }
  }

  Future<void> navToDetail(BuildContext context, Restaurant restaurant) async {
    await Navigator.pushNamed(
      context,
      RouteEnum.detail.name,
      arguments: restaurant,
    );

    fetchData();
  }

  Future<void> removeFromWishlist(
    BuildContext context,
    Restaurant? restaurant,
  ) async {
    try {
      if (restaurant == null) return;
      await SqliteService.removeItem(restaurant.id ?? '');
      if (!context.mounted) return;

      showSnackbar(
        context,
        '${restaurant.name} removed to wishlist',
      );

      fetchData();
    } catch (_) {
      resultState = ViewErrorState(
          'Sorry, something is wrong when updating your wishlist.');
    }
  }
}
