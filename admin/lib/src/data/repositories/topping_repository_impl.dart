import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/core/utils/extensions/dio_extension.dart';

import 'package:coffee_admin/src/data/remote/response/topping/topping_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/request/topping_request/topping_request.dart';
import '../../domain/repositories/topping_repository.dart';
import '../remote/api_service/api_service.dart';
import '../remote/firebase/firebase_service.dart';

@LazySingleton(as: ToppingRepository)
class ToppingRepositoryImpl extends ToppingRepository {
  final ApiService _apiService;
  final SharedPreferences _sharedPref;

  ToppingRepositoryImpl(this._apiService, this._sharedPref);

  @override
  Future<DataState<ToppingResponse>> createTopping(
      ToppingRequest request) async {
    try {
      final token = _sharedPref.get("token") ?? "";
      if (request.image.isNotEmpty) {
        request.topping.imageUrl = await uploadImage(
          folder: "topping",
          name: request.image.split("/").last,
          image: request.image,
        );
      }
      final response = await _apiService.createNewTopping(
          'Bearer $token', request.topping.toJson());
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
  Future<DataState<ToppingResponse>> deleteTopping(String id) async {
    try {
      final token = _sharedPref.get("token") ?? "";
      final response = await _apiService.removeToppingByID("Bearer $token", id);
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
  Future<DataState<List<ToppingResponse>>> getTopping() async {
    try {
      final response = await _apiService.getAllToppings();
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
  Future<DataState<ToppingResponse>> updateTopping(
      ToppingRequest request) async {
    try {
      final token = _sharedPref.get("token") ?? "";
      if (request.image.isNotEmpty) {
        request.topping.imageUrl = await uploadImage(
          folder: "topping",
          name: request.image.split("/").last,
          image: request.image,
        );
      }
      final response = await _apiService.updateExistingTopping(
        request.topping.toppingId!,
        'Bearer $token',
        request.topping.toJson(),
      );
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
