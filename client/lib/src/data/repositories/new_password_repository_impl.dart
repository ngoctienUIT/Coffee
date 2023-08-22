import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/core/utils/extensions/dio_extension.dart';
import 'package:coffee/src/data/remote/api_service/api_service.dart';

import 'package:coffee/src/data/remote/response/user/user_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../core/request/new_password_request/new_password_request.dart';
import '../../domain/repositories/new_password_repository.dart';

@LazySingleton(as: NewPasswordRepository)
class NewPasswordRepositoryImpl extends NewPasswordRepository {
  NewPasswordRepositoryImpl(this._apiService);

  final ApiService _apiService;

  @override
  Future<DataState<UserResponse>> sendApi(NewPasswordRequest request) async {
    try {
      final response = await _apiService.issueNewPasswordUser(
          request.resetCredential, request.password);
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
