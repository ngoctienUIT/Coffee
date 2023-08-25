import 'dart:convert';

import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/core/utils/extensions/dio_extension.dart';

import 'package:coffee_admin/src/data/remote/response/login/login_response.dart';

import 'package:coffee_admin/src/presentation/login/bloc/login_event.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/login_repository.dart';
import '../remote/api_service/api_service.dart';

@LazySingleton(as: LoginRepository)
class LoginRepositoryImpl extends LoginRepository {
  final ApiService _apiService;
  final SharedPreferences _sharedPref;

  LoginRepositoryImpl(this._apiService, this._sharedPref);

  @override
  Future<DataState<LoginResponse>> loginWithEmailPassword(
      LoginWithEmailPasswordEvent event) async {
    try {
      var bytes = utf8.encode(event.password);
      var digest = sha256.convert(bytes);
      print("Digest as hex string: $digest");
      final response = await _apiService.login(
          {"loginIdentity": event.email, "hashedPassword": digest.toString()});
      final user = response.data;
      if (user.userResponse.userRole == "CUSTOMER") {
        return DataFailed("Không có quyền truy cập ứng dụng");
      } else {
        _sharedPref.setString("userID", user.userResponse.id);
        _sharedPref.setString("token", user.accessToken);
        print(user.accessToken);
        return DataSuccess(response.data);
      }
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
