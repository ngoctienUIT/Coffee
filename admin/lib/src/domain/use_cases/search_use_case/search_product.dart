import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:coffee_admin/src/data/remote/response/product/product_response.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../repositories/search_repository.dart';

@lazySingleton
class SearchProductUseCase
    extends UseCase<DataState<List<ProductResponse>>, String> {
  final SearchRepository _repository;

  SearchProductUseCase(this._repository);

  @override
  Future<DataState<List<ProductResponse>>> call({required String params}) {
    return _repository.searchProduct(params);
  }
}
