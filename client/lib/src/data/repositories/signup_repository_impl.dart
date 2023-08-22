import 'package:coffee/src/core/utils/extensions/dio_extension.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../core/request/signup_request/signup_email_password_request.dart';
import '../../core/resources/data_state.dart';
import '../../domain/repositories/signup_repository.dart';
import '../remote/api_service/api_service.dart';
import '../remote/response/user/user_response.dart';

@LazySingleton(as: SignupRepository)
class SignupRepositoryImpl extends SignupRepository {
  final ApiService _apiService;

  SignupRepositoryImpl(this._apiService);

  @override
  Future<DataState<UserResponse>> signupWithEmailPassword(
      SignupEmailPasswordRequest request) async {
    try {
      var response = await _apiService.signup(request.user.toJson());
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
