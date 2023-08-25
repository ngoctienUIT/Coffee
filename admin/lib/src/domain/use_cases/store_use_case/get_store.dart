import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:coffee_admin/src/data/local/entity/store_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../repositories/store_repository.dart';

@lazySingleton
class GetStoreUseCase extends UseCase<DataState<List<StoreEntity>>, String> {
  final StoreRepository _storeRepository;

  GetStoreUseCase(this._storeRepository);

  @override
  Future<DataState<List<StoreEntity>>> call({required String params}) {
    return _storeRepository.getStore(params);
  }
}
