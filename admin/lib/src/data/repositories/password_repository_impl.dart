import 'dart:convert';

import 'package:coffee_admin/src/core/request/password_request/input_pin_request.dart';
import 'package:coffee_admin/src/core/request/password_request/new_password_request.dart';
import 'package:coffee_admin/src/core/utils/extensions/dio_extension.dart';
import 'package:coffee_admin/src/data/models/user.dart';
import 'package:coffee_admin/src/domain/repositories/password_repository.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/resources/data_state.dart';
import '../remote/api_service/api_service.dart';
import '../remote/response/user/user_response.dart';

@LazySingleton(as: PasswordRepository)
class PasswordRepositoryImpl extends PasswordRepository {
  final ApiService _apiService;
  final SharedPreferences _sharedPref;

  PasswordRepositoryImpl(this._apiService, this._sharedPref);

  @override
  Future<DataState<UserResponse>> changePassword(User user) async {
    try {
      final token = _sharedPref.get("token") ?? "";
      final response = await _apiService.updateExistingUser(
          "Bearer $token", user.email, user.toJson());
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

  @override
  Future<DataState<UserResponse>> createNewPassword(
      NewPasswordRequest request) async {
    try {
      var bytes = utf8.encode(request.password);
      var digest = sha256.convert(bytes);
      print("Digest as hex string: $digest");
      final response = await _apiService.issueNewPasswordUser(
          request.resetCredential, digest.toString());
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

  @override
  Future<DataState<String>> forgotPassword(String email) async {
    try {
      final response = await _apiService.resetPasswordIssue(email);
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

  @override
  Future<DataState<bool>> inputPin(InputPinRequest request) async {
    try {
      final response = await _apiService.validateResetTokenClient(
          request.resetCredential, request.pin);
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
