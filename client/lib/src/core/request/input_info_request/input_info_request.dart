import 'package:google_sign_in/google_sign_in.dart';

import '../../../data/models/user.dart';

class InputInfoRequest {
  final User user;
  final GoogleSignInAccount account;

  InputInfoRequest({required this.user, required this.account});
}
