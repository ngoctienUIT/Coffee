import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/request/store_request/store_request.dart';
import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/store/store_response.dart';
import '../../repositories/store_repository.dart';

@lazySingleton
class CreateStoreUseCase
    extends UseCase<DataState<StoreResponse>, StoreRequest> {
  final StoreRepository _storeRepository;

  CreateStoreUseCase(this._storeRepository);

  @override
  Future<DataState<StoreResponse>> call({required StoreRequest params}) {
    return _storeRepository.createStore(params);
  }
}
