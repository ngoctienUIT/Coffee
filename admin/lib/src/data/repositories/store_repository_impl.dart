import 'package:coffee_admin/src/core/request/store_request/store_request.dart';
import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/core/utils/extensions/dio_extension.dart';
import 'package:coffee_admin/src/data/local/dao/store_dao.dart';

import 'package:coffee_admin/src/data/local/entity/store_entity.dart';

import 'package:coffee_admin/src/data/remote/response/store/store_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/store_repository.dart';
import '../remote/api_service/api_service.dart';
import '../remote/firebase/firebase_service.dart';

@LazySingleton(as: StoreRepository)
class StoreRepositoryImpl extends StoreRepository {
  final ApiService _apiService;
  final SharedPreferences _sharedPref;
  final StoreDao _storeDao;

  StoreRepositoryImpl(this._apiService, this._sharedPref, this._storeDao);

  @override
  Future<DataState<StoreResponse>> createStore(StoreRequest request) async {
    try {
      final token = _sharedPref.get("token") ?? "";
      if (request.image.isNotEmpty) {
        request.store.imageUrl = await uploadImage(
          folder: "store",
          name: request.image.split("/").last,
          image: request.image,
        );
      }
      final response = await _apiService.registerNewStore(
          'Bearer $token', request.store.toJson());
      _storeDao.insertStore(response.data.toStoreEntity());
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
  Future<DataState<StoreResponse>> deleteStore(String id) async {
    try {
      final token = _sharedPref.get("token") ?? "";
      final response = await _apiService.removeStoreByID(id, "Bearer $token");
      _storeDao.deleteStore(response.data.toStoreEntity());
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
  Future<DataState<List<StoreResponse>>> fetchDataStore() async {
    try {
      final response = await _apiService.getAllStores();
      await _storeDao.deleteAllStore();
      _storeDao.insertListStore(
          response.data.map((e) => e.toStoreEntity()).toList());
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
  Future<DataState<List<StoreEntity>>> getStore(String query) async {
    return DataSuccess(await _storeDao.findStoreByName(query).first);
  }

  @override
  Future<DataState<StoreResponse>> updateStore(StoreRequest request) async {
    final token = _sharedPref.get("token") ?? "";
    try {
      if (request.image.isNotEmpty) {
        request.store.imageUrl = await uploadImage(
          folder: "store",
          name: request.image.split("/").last,
          image: request.image,
        );
      }
      final response = await _apiService.updateExistingStore(
          request.store.storeId!, 'Bearer $token', request.store.toJson());
      _storeDao.updateStore(response.data.toStoreEntity());
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
