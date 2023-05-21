abstract class HomeEvent {}

class FetchData extends HomeEvent {
  bool check;

  FetchData({this.check = true});
}

class ChangeBannerEvent extends HomeEvent {}

class GetOrderSpendingEvent extends HomeEvent {}

class GetCouponEvent extends HomeEvent {}
