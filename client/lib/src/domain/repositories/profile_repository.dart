import 'package:coffee/src/data/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/request/profile_request/save_profile_request.dart';
import '../../core/resources/data_state.dart';

abstract class ProfileRepository {
  Future<DataState> linkAccountWithGoogle(GoogleSignInAccount googleUser);

  Future<DataState> unlinkAccountWithGoogle();

  Future<DataState<User>> saveProfile(SaveProfileRequest request);

  Future<DataState<User>> deleteAvatar(User user);
}
