import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {}

class FetchData extends HomeEvent {
  final bool check;

  FetchData({this.check = true});

  @override
  List<Object?> get props => [check];
}

class ChangeBannerEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class GetOrderSpendingEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class GetCouponEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}
