import 'package:coffee/src/core/utils/extensions/dio_extension.dart';
import 'package:coffee/src/data/local/dao/store_dao.dart';
import 'package:coffee/src/data/remote/api_service/api_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../core/resources/data_state.dart';
import '../../domain/repositories/store_repository.dart';
import '../local/entity/store_entity.dart';

@LazySingleton(as: StoreRepository)
class StoreRepositoryImpl extends StoreRepository {
  StoreRepositoryImpl(this._storeDao, this._apiService);

  final StoreDao _storeDao;
  final ApiService _apiService;

  @override
  Future<DataState<List<StoreEntity>>> fetchDataStore() async {
    try {
      final storeResponse = await _apiService.getAllStores();
      final list = storeResponse.data.map((e) => e.toStoreEntity()).toList();
      _storeDao.insertListStore(list);
      return DataSuccess(list);
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
  Future<DataState<List<StoreEntity>>> getStore() async {
    return DataSuccess(await _storeDao.getListStore().first);
  }

  @override
  Future<DataState<List<StoreEntity>>> searchStore(String name) async {
    return DataSuccess(await _storeDao.findStoreByName(name).first);
  }
}
