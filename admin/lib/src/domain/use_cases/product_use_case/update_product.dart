import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/request/product_request/product_request.dart';
import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/product/product_response.dart';
import '../../repositories/product_repository.dart';

@lazySingleton
class UpdateProductUseCase
    extends UseCase<DataState<ProductResponse>, ProductRequest> {
  final ProductRepository _repository;

  UpdateProductUseCase(this._repository);

  @override
  Future<DataState<ProductResponse>> call({required ProductRequest params}) {
    return _repository.updateProduct(params);
  }
}
