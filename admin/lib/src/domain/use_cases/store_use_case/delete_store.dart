import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/store/store_response.dart';
import '../../repositories/store_repository.dart';

@lazySingleton
class DeleteStoreUseCase extends UseCase<DataState<StoreResponse>, String> {
  final StoreRepository _storeRepository;

  DeleteStoreUseCase(this._storeRepository);

  @override
  Future<DataState<StoreResponse>> call({required String params}) {
    return _storeRepository.deleteStore(params);
  }
}
