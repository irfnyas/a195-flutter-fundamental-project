import 'package:flutter/widgets.dart';

import '../../data/api/api_service.dart';
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

  Future<void> fetchData(String id) async {
    try {
      resultState = ViewLoadingState();
      final result = await apiService.getRestaurant(id);
      resultState = result.error == true
          ? ViewErrorState(result.message ?? '')
          : ViewLoadedState(restaurant: result.restaurant);
    } on Exception catch (e) {
      resultState = ViewErrorState('$e');
    }
  }
}
