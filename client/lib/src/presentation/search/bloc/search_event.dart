import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {}

class SearchProduct extends SearchEvent {
  final String query;

  SearchProduct({required this.query});

  @override
  List<Object?> get props => [this.query];
}
