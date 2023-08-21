import 'package:coffee/src/data/local/entity/store_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class StoreDao {
  @Query('SELECT * FROM Store WHERE storeId = :id')
  Stream<StoreEntity?> findStoreById(String id);

  @Query('SELECT * FROM Store WHERE storeName LIKE \'%\'|| :name || \'%\'')
  Stream<List<StoreEntity>> findStoreByName(String name);

  @Query('SELECT * FROM Store')
  Stream<List<StoreEntity>> getListStore();

  @Query('SELECT COUNT(*) FROM Store')
  Future<int?> getNumberStore();

  @insert
  Future<void> insertStore(StoreEntity store);

  @insert
  Future<void> insertListStore(List<StoreEntity> list);

  @update
  Future<void> updateStore(StoreEntity store);

  @delete
  Future<void> deleteStore(StoreEntity store);

  @Query('DELETE FROM Store')
  Future<void> deleteAllStore();
}
