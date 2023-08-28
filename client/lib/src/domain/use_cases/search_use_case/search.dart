import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../data/remote/response/product/product_response.dart';
import '../../repositories/search_repository.dart';

@lazySingleton
class SearchUseCase extends UseCase<DataState<List<ProductResponse>>, String> {
  SearchUseCase(this._repository);

  final SearchRepository _repository;

  @override
  Future<DataState<List<ProductResponse>>> call({required String params}) {
    return _repository.search(params);
  }
}
