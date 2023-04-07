abstract class SearchStaffEvent {}

class SearchStaff extends SearchStaffEvent {
  final String query;

  SearchStaff(this.query);
}
