import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/product_catalogues/product_catalogues_response.dart';
import '../../repositories/product_catalogues_repository.dart';

@lazySingleton
class DeleteProductCataloguesUseCase
    extends UseCase<DataState<ProductCataloguesResponse>, String> {
  final ProductCataloguesRepository _repository;

  DeleteProductCataloguesUseCase(this._repository);

  @override
  Future<DataState<ProductCataloguesResponse>> call({required String params}) {
    return _repository.deleteProductCatalogues(params);
  }
}
