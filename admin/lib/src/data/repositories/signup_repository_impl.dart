import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/core/utils/extensions/dio_extension.dart';

import 'package:coffee_admin/src/data/models/user.dart';

import 'package:coffee_admin/src/data/remote/response/user/user_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/signup_repository.dart';
import '../remote/api_service/api_service.dart';

@LazySingleton(as: SignUpRepository)
class SignUpRepositoryImpl extends SignUpRepository {
  final ApiService _apiService;

  SignUpRepositoryImpl(this._apiService);

  @override
  Future<DataState<UserResponse>> signUpWithEmailPassword(User user) async {
    try {
      final response = await _apiService.signup(user.toJson());
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
