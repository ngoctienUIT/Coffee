import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart' as inject;

import '../../../core/request/product_request/update_product_in_order_request.dart';
import '../../../core/resources/data_state.dart';
import '../../../data/models/order.dart';
import '../../repositories/product_repository.dart';

@inject.lazySingleton
class UpdateProductInOrderUseCase
    extends UseCase<DataState<Order?>, UpdateProductInOrderRequest> {
  final ProductRepository _repository;

  UpdateProductInOrderUseCase(this._repository);

  @override
  Future<DataState<Order?>> call(
      {required UpdateProductInOrderRequest params}) {
    return _repository.updateProductInOrder(params);
  }
}
