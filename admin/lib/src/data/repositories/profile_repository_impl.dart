import 'package:coffee_admin/src/core/request/profile_request/save_profile_request.dart';

import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/core/utils/extensions/dio_extension.dart';

import 'package:coffee_admin/src/data/models/user.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/profile_repository.dart';
import '../remote/api_service/api_service.dart';
import '../remote/firebase/firebase_service.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl extends ProfileRepository {
  final ApiService _apiService;
  final SharedPreferences _sharedPref;

  ProfileRepositoryImpl(this._apiService, this._sharedPref);

  @override
  Future<DataState<User>> deleteAvatar(User user) async {
    try {
      String token = _sharedPref.getString("token") ?? "";
      user.imageUrl = null;
      final response = await _apiService.updateExistingUser(
          "Bearer $token", user.email, user.toJson());
      return DataSuccess(User.fromUserResponse(response.data));
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
  Future<DataState<User>> saveProfile(SaveProfileRequest request) async {
    try {
      String token = _sharedPref.getString("token") ?? "";
      if (request.image.isNotEmpty) {
        request.user.imageUrl = await uploadImage(
          folder: "avatar",
          name: request.image.split("/").last,
          image: request.image,
        );
      }
      final response = await _apiService.updateExistingUser(
          "Bearer $token", request.user.email, request.user.toJson());
      return DataSuccess(User.fromUserResponse(response.data));
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
