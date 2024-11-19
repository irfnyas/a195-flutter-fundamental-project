import 'package:flutter/widgets.dart';

import '../../data/model/restaurant_model.dart';
import '../../data/service/api_service.dart';
import '../../util/route.dart';
import '../../util/view_result_state.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider(this.apiService);

  final ApiService apiService;

  ViewResultState _resultState = ViewNoneState();
  ViewResultState get resultState => _resultState;
  set resultState(ViewResultState value) {
    _resultState = value;
    notifyListeners();
  }

  Future<void> fetchData() async {
    try {
      resultState = ViewLoadingState();
      final result = await apiService.getRestaurants();
      resultState = result.error == true
          ? ViewErrorState(result.message ?? '')
          : ViewLoadedState(restaurants: result.restaurants ?? []);
    } on Exception catch (_) {
      resultState = ViewErrorState(ApiService.exceptionMessage);
    }
  }

  void navToDetail(BuildContext context, Restaurant restaurant) {
    Navigator.pushNamed(
      context,
      RouteEnum.detail.name,
      arguments: restaurant,
    );
  }

  void navToSettings(BuildContext context) {
    Navigator.pushNamed(
      context,
      RouteEnum.settings.name,
    );
  }

  void navToWishlist(BuildContext context) {
    Navigator.pushNamed(
      context,
      RouteEnum.wishlist.name,
    );
  }
}
