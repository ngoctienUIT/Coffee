import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/local/entity/store_entity.dart';
import '../../repositories/store_repository.dart';

@lazySingleton
class GetStoreUseCase extends UseCase<DataState<List<StoreEntity>>, dynamic> {
  GetStoreUseCase(this._repository);

  final StoreRepository _repository;

  @override
  Future<DataState<List<StoreEntity>>> call({params}) {
    return _repository.getStore();
  }
}
