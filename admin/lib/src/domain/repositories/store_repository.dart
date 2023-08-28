import 'package:coffee_admin/src/data/local/entity/store_entity.dart';
import 'package:coffee_admin/src/data/remote/response/store/store_response.dart';

import '../../core/request/store_request/store_request.dart';
import '../../core/resources/data_state.dart';

abstract class StoreRepository {
  Future<DataState<List<StoreResponse>>> fetchDataStore();

  Future<DataState<List<StoreEntity>>> getStore(String query);

  Future<DataState<StoreResponse>> createStore(StoreRequest request);

  Future<DataState<StoreResponse>> updateStore(StoreRequest request);

  Future<DataState<StoreResponse>> deleteStore(String id);
}
