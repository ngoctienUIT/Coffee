import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/data/local/entity/store_entity.dart';

abstract class StoreRepository {
  Future<DataState<List<StoreEntity>>> getStore();

  Future<DataState<List<StoreEntity>>> searchStore(String name);

  Future<DataState<List<StoreEntity>>> fetchDataStore();
}
