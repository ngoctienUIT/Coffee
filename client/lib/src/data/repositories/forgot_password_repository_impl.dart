import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/core/utils/extensions/dio_extension.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/forgot_password_repository.dart';
import '../remote/api_service/api_service.dart';

@LazySingleton(as: ForgotPasswordRepository)
class ForgotPasswordRepositoryImpl extends ForgotPasswordRepository {
  ForgotPasswordRepositoryImpl(this._apiService);

  final ApiService _apiService;

  @override
  Future<DataState<String>> sendEmail(String email) async {
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
}
