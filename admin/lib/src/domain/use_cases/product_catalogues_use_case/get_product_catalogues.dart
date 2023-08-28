import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/product_catalogues/product_catalogues_response.dart';
import '../../repositories/product_catalogues_repository.dart';

@lazySingleton
class GetProductCataloguesUseCase
    extends UseCase<DataState<List<ProductCataloguesResponse>>, dynamic> {
  final ProductCataloguesRepository _repository;

  GetProductCataloguesUseCase(this._repository);

  @override
  Future<DataState<List<ProductCataloguesResponse>>> call({params}) {
    return _repository.getAllProductCatalogues();
  }
}
