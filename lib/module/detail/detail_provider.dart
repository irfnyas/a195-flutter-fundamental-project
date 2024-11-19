import 'package:flutter/widgets.dart';

import '../../data/model/restaurant_model.dart';
import '../../data/service/api_service.dart';
import '../../data/service/sqlite_service.dart';
import '../../util/modal.dart';
import '../../util/view_result_state.dart';

class DetailProvider extends ChangeNotifier {
  DetailProvider(this.apiService);

  final ApiService apiService;

  ViewResultState _resultState = ViewNoneState();
  ViewResultState get resultState => _resultState;
  set resultState(ViewResultState value) {
    _resultState = value;
    notifyListeners();
  }

  bool _isWishlisted = false;
  bool get isWishlisted => _isWishlisted;
  set isWishlisted(bool value) {
    _isWishlisted = value;
    notifyListeners();
  }

  Future<void> fetchData(String id) async {
    try {
      resultState = ViewLoadingState();
      final result = await apiService.getRestaurant(id);
      isWishlisted = await SqliteService.getItemById(id) != null;
      resultState = result.error == true
          ? ViewErrorState(result.message ?? '')
          : ViewLoadedState(restaurant: result.restaurant);
    } on Exception catch (_) {
      resultState = ViewErrorState(ApiService.exceptionMessage);
    }
  }

  Future<void> switchWishlist(
    BuildContext context,
    Restaurant? restaurant,
  ) async {
    try {
      if (restaurant == null) return;
      isWishlisted
          ? await SqliteService.removeItem(restaurant.id ?? '')
          : await SqliteService.insertItem(restaurant);
      if (!context.mounted) return;
      isWishlisted = !isWishlisted;
      showSnackbar(
        context,
        'Restaurant ${isWishlisted ? 'added' : 'removed'} to wishlist',
      );
    } catch (_) {
      resultState = ViewErrorState('Updating wishlist failed.');
    }
  }
}
