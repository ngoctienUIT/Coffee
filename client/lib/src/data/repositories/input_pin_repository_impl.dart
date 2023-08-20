import 'package:coffee/src/core/request/input_pin_request/input_pin_request.dart';

import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/data/remote/api_service/api_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/input_pin_repository.dart';

@LazySingleton(as: InputPinRepository)
class InputPinRepositoryImpl extends InputPinRepository {
  InputPinRepositoryImpl(this._apiService);

  final ApiService _apiService;

  @override
  Future<DataState<bool>> sendApi(InputPinRequest request) async {
    try {
      final response = await _apiService.validateResetTokenClient(
          request.resetCredential, request.pin);
      return DataSuccess(response.data);
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
