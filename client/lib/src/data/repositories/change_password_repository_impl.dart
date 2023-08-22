import 'package:coffee/injection.dart';
import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/core/utils/extensions/dio_extension.dart';
import 'package:coffee/src/data/local/dao/user_dao.dart';
import 'package:coffee/src/data/remote/api_service/api_service.dart';

import 'package:coffee/src/data/remote/response/user/user_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/change_password_repository.dart';
import '../models/user.dart';

@LazySingleton(as: ChangePasswordRepository)
class ChangePasswordRepositoryImpl extends ChangePasswordRepository {
  ChangePasswordRepositoryImpl(
    this._apiService,
    this._sharedPref,
    this._userDao,
  );

  final ApiService _apiService;
  final SharedPreferences _sharedPref;
  final UserDao _userDao;

  @override
  Future<DataState<UserResponse>> changePassword(User user) async {
    try {
      String token = _sharedPref.getString("token") ?? "";
      User? userEntity = getIt<User>();
      final response = await _apiService.updateExistingUser(
          "Bearer $token", userEntity.email, user.toJson());
      _userDao.updateUser(response.data.toUserEntity());
      return DataSuccess(response.data);
    } on DioException catch (e) {
      String error = e.getError();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }
}
