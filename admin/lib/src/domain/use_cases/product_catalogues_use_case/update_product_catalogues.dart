import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/request/product_catalogues_request/product_catalogues_request.dart';
import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/product_catalogues/product_catalogues_response.dart';
import '../../repositories/product_catalogues_repository.dart';

@lazySingleton
class UpdateProductCataloguesUseCase extends UseCase<
    DataState<ProductCataloguesResponse>, ProductCataloguesRequest> {
  final ProductCataloguesRepository _repository;

  UpdateProductCataloguesUseCase(this._repository);

  @override
  Future<DataState<ProductCataloguesResponse>> call(
      {required ProductCataloguesRequest params}) {
    return _repository.updateProductCatalogues(params);
  }
}
