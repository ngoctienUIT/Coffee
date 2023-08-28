import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/store/store_response.dart';
import '../../repositories/store_repository.dart';

@lazySingleton
class FetchStoreUseCase
    extends UseCase<DataState<List<StoreResponse>>, dynamic> {
  final StoreRepository _storeRepository;

  FetchStoreUseCase(this._storeRepository);

  @override
  Future<DataState<List<StoreResponse>>> call({params}) {
    return _storeRepository.fetchDataStore();
  }
}
