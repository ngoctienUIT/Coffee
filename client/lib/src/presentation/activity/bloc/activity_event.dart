import 'package:equatable/equatable.dart';

abstract class ActivityEvent extends Equatable {}

class FetchData extends ActivityEvent {
  final int index;

  FetchData(this.index);

  @override
  List<Object?> get props => [index];
}

class UpdateData extends ActivityEvent {
  final int index;

  UpdateData(this.index);

  @override
  List<Object?> get props => [index];
}
