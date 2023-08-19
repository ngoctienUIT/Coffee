import 'dart:convert';

import 'package:coffee/src/core/request/login_request/login_email_password_request.dart';
import 'package:coffee/src/core/request/login_request/login_google_request.dart';
import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/data/remote/api_service/api_service.dart';

import 'package:coffee/src/data/remote/response/login/login_response.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  LoginRepositoryImpl(this._apiService, this._sharedPref);

  final ApiService _apiService;
  final SharedPreferences _sharedPref;

  @override
  Future<DataState<LoginResponse>> loginWithEmailPassword(
      LoginEmailPasswordRequest request) async {
    try {
      var bytes = utf8.encode(request.password);
      var digest = sha256.convert(bytes);
      print("Digest as hex string: $digest");
      final response = await _apiService.login({
        "loginIdentity": request.email,
        "hashedPassword": digest.toString()
      });
      final user = response.data;
      _sharedPref.setString("userID", user.userResponse.id);
      _sharedPref.setString("token", user.accessToken);
      print(user.accessToken);
      return DataSuccess(user);
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      return DataFailed(error);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<LoginResponse>> loginWithGoogle(
      LoginGoogleRequest request) async {
    try {
      final GoogleSignInAuthentication googleAuth =
          await request.googleUser.authentication;
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.loginCredentialTokenOAuth2({
        "oauth2ProviderUserId": request.googleUser.id,
        "oauth2ProviderUserIdentity": request.googleUser.email,
        "oauth2ProviderAccessToken": googleAuth.accessToken,
        "oauth2ProviderProviderName": "GOOGLE"
      });
      print("token: ${googleAuth.accessToken}");
      _sharedPref.setString("userID", response.data.userResponse.id);
      _sharedPref.setString("token", response.data.accessToken);
      _sharedPref.setString("username", request.googleUser.email);
      _sharedPref.setBool("isLogin", true);
      return DataSuccess(response.data);
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      return DataFailed(error);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
