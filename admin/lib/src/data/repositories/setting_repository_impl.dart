import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/core/utils/extensions/dio_extension.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/setting_repository.dart';
import '../remote/api_service/api_service.dart';

@LazySingleton(as: SettingRepository)
class SettingRepositoryImpl extends SettingRepository {
  final ApiService _apiService;
  final SharedPreferences _sharedPref;

  SettingRepositoryImpl(this._apiService, this._sharedPref);

  @override
  Future<DataState> deleteAccount() async {
    try {
      String id = _sharedPref.getString("userID") ?? "";
      String token = _sharedPref.getString("token") ?? "";
      await _apiService.removeUserByID("Bearer $token", id);
      _sharedPref.setBool("isLogin", false);
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
}
