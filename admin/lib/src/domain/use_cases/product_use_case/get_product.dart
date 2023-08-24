import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/product/product_response.dart';
import '../../repositories/product_repository.dart';

@lazySingleton
class GetProductUseCase
    extends UseCase<DataState<List<ProductResponse>>, String> {
  final ProductRepository _repository;

  GetProductUseCase(this._repository);

  @override
  Future<DataState<List<ProductResponse>>> call({required String params}) {
    return _repository.getAllProductsFromProductCatalogueID(params);
  }
}
