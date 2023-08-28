import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/product_catalogues/product_catalogues_response.dart';
import '../../repositories/order_repository.dart';

@lazySingleton
class GetListProductCatalogues
    extends UseCase<DataState<List<ProductCataloguesResponse>>, dynamic> {
  GetListProductCatalogues(this._repository);

  final OrderRepository _repository;

  @override
  Future<DataState<List<ProductCataloguesResponse>>> call({params}) {
    return _repository.getProductCatalogues();
  }
}
