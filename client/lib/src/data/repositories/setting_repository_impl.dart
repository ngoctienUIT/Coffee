import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/data/remote/api_service/api_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/setting_repository.dart';

@LazySingleton(as: SettingRepository)
class SettingRepositoryImpl extends SettingRepository {
  SettingRepositoryImpl(this._apiService, this._prefs);

  final ApiService _apiService;
  final SharedPreferences _prefs;

  @override
  Future<DataState> deleteAccount() async {
    try {
      String id = _prefs.getString("userID") ?? "";
      String token = _prefs.getString("token") ?? "";
      String email = _prefs.getString("username") ?? "";
      final response =
          await _apiService.getAllOrders("Bearer $token", email, "PLACED");
      if (response.data.isEmpty) {
        await _apiService.removeUserByID("Bearer $token", id);
        _prefs.setBool("isLogin", false);
        return DataSuccess("ok");
      } else {
        return DataFailed(
            "Bạn vẫn còn ${response.data.length} đơn hàng chưa hoàn tất");
      }
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }
}
