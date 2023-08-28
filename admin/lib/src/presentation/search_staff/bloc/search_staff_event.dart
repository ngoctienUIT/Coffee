import 'package:equatable/equatable.dart';

abstract class SearchStaffEvent extends Equatable {}

class SearchStaff extends SearchStaffEvent {
  final String query;

  SearchStaff(this.query);

  @override
  List<Object?> get props => [query];
}
