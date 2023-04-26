abstract class HomeEvent {}

class FetchData extends HomeEvent {
  bool check;

  FetchData({this.check = true});
}

class ChangeBannerEvent extends HomeEvent {}

class AddProductToCart extends HomeEvent {}
