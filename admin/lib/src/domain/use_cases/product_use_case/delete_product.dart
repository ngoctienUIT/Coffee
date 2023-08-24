import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/request/product_request/delete_product_request.dart';
import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/product/product_response.dart';
import '../../repositories/product_repository.dart';

@lazySingleton
class DeleteProductUseCase
    extends UseCase<DataState<ProductResponse>, DeleteProductRequest> {
  final ProductRepository _repository;

  DeleteProductUseCase(this._repository);

  @override
  Future<DataState<ProductResponse>> call(
      {required DeleteProductRequest params}) {
    return _repository.deleteProduct(params);
  }
}
