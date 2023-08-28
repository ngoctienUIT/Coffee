import 'package:coffee_admin/injection.dart';
import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/core/utils/extensions/dio_extension.dart';
import 'package:coffee_admin/src/core/utils/extensions/list_extension.dart';

import 'package:coffee_admin/src/data/remote/response/product/product_response.dart';

import 'package:coffee_admin/src/data/remote/response/user/user_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/search_repository.dart';
import '../models/user.dart';
import '../remote/api_service/api_service.dart';

@LazySingleton(as: SearchRepository)
class SearchRepositoryImpl extends SearchRepository {
  final ApiService _apiService;

  SearchRepositoryImpl(this._apiService);

  @override
  Future<DataState<List<ProductResponse>>> searchProduct(String query) async {
    try {
      final response = await _apiService.searchProductsByName(query);
      return DataSuccess(response.data);
    } on DioException catch (e) {
      String error = e.getError();
      print(e);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<UserResponse>>> searchStaff(String query) async {
    try {
      User user = getIt<User>();
      final response = await _apiService.searchUserByName(query);
      final listAccount = response.data.filterAdminAndStaff(user.email);
      return DataSuccess(listAccount);
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
