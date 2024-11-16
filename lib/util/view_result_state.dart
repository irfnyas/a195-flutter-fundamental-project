import '../data/model/restaurant_model.dart';

sealed class ViewResultState {}

class ViewNoneState extends ViewResultState {}

class ViewLoadingState extends ViewResultState {}

class ViewErrorState extends ViewResultState {
  ViewErrorState(this.error);
  final String error;
}

class ViewLoadedState extends ViewResultState {
  ViewLoadedState({this.restaurants, this.restaurant});
  final List<Restaurant>? restaurants;
  final Restaurant? restaurant;
}
