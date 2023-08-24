import '../../../data/remote/response/user/user_response.dart';

extension FilterList on List<UserResponse> {
  List<UserResponse> filterAdminAndStaff(String email) {
    return where((element) =>
        element.email != email &&
        (element.userRole == "ADMIN" || element.userRole == "STAFF")).toList();
  }

  List<UserResponse> filter({required String type, required String email}) {
    return where(
            (element) => element.email != email && element.userRole == type)
        .toList();
  }
}
