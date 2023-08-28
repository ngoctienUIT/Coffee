import '../../core/resources/data_state.dart';
import '../../data/remote/response/user/user_response.dart';

abstract class AccountManagementRepository {
  Future<DataState<List<UserResponse>>> getAllAccount();

  Future<DataState> deleteAccount(String id);
}
