import 'package:coffee/src/data/models/user.dart';

class SaveProfileRequest {
  String image;
  User user;

  SaveProfileRequest({required this.image, required this.user});
}
