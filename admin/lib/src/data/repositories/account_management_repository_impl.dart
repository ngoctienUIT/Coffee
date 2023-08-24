import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/core/utils/extensions/dio_extension.dart';
import 'package:coffee_admin/src/data/remote/api_service/api_service.dart';

import 'package:coffee_admin/src/data/remote/response/user/user_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/account_management_repository.dart';

@LazySingleton(as: AccountManagementRepository)
class AccountManagementRepositoryImpl extends AccountManagementRepository {
  final ApiService _apiService;
  final SharedPreferences _sharedPref;

  AccountManagementRepositoryImpl(this._apiService, this._sharedPref);

  @override
  Future<DataState> deleteAccount(String id) async {
    try {
      final token = _sharedPref.get("token") ?? "";
      await _apiService.removeUserByID('Bearer $token', id);
      return DataSuccess(null);
    } on DioException catch (e) {
      String error = e.getError();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<UserResponse>>> getAllAccount() async {
    try {
      final token = _sharedPref.get("token") ?? "";
      final response = await _apiService.getAllUsers('Bearer $token');
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
