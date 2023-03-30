abstract class SearchEvent {}

class SearchProduct extends SearchEvent {
  final String query;

  SearchProduct({required this.query});
}
