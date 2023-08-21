import 'dart:io';

import 'package:coffee/injection.dart';
import 'package:coffee/src/core/resources/data_state.dart';

import 'package:coffee/src/data/models/user.dart';
import 'package:coffee/src/data/remote/api_service/api_service.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/request/profile_request/save_profile_request.dart';
import '../../domain/repositories/profile_repository.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl extends ProfileRepository {
  ProfileRepositoryImpl(this._sharedPref, this._apiService);

  final SharedPreferences _sharedPref;
  final ApiService _apiService;

  @override
  Future<DataState<User>> deleteAvatar(User user) async {
    try {
      final token = _sharedPref.getString("token") ?? "";
      user.imageUrl = null;
      final response = await _apiService.updateExistingUser(
          "Bearer $token", getIt<User>().username, user.toJson());
      return DataSuccess(User.fromUserResponse(response.data));
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

  @override
  Future<DataState> linkAccountWithGoogle(
      GoogleSignInAccount googleUser) async {
    try {
      final token = _sharedPref.getString("token") ?? "";
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      await _apiService.linkAccountWithOAuth2Provider(
        "Bearer $token",
        {
          "oauth2ProviderUserId": googleUser.id,
          "oauth2ProviderUserIdentity": googleUser.email,
          "oauth2ProviderAccessToken": googleAuth.accessToken,
          "oauth2ProviderProviderName": "GOOGLE",
        },
      );
      return DataSuccess(null);
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

  @override
  Future<DataState<User>> saveProfile(SaveProfileRequest request) async {
    try {
      final token = _sharedPref.getString("token") ?? "";
      if (request.image.isNotEmpty) {
        request.user.imageUrl =
            await uploadImage(getIt<User>().username, request.image);
      }
      final response = await _apiService.updateExistingUser(
          "Bearer $token", getIt<User>().username, request.user.toJson());
      return DataSuccess(User.fromUserResponse(response.data));
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

  @override
  Future<DataState> unlinkAccountWithGoogle() async {
    try {
      final token = _sharedPref.getString("token") ?? "";
      await _apiService.unlinkAccountWithOAuth2Provider(
          "Bearer $token", getIt<User>().id!);
      return DataSuccess(null);
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

  Future<String> uploadImage(String name, String image) async {
    Reference upload = FirebaseStorage.instance.ref().child("avatar/$name");
    await upload.putFile(File(image));
    return await upload.getDownloadURL();
  }
}
