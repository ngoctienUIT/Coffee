import '../../core/request/profile_request/save_profile_request.dart';
import '../../core/resources/data_state.dart';
import '../../data/models/user.dart';

abstract class ProfileRepository {
  Future<DataState<User>> saveProfile(SaveProfileRequest request);

  Future<DataState<User>> deleteAvatar(User user);
}