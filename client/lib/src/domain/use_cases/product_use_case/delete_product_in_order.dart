import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart' as inject;

import '../../../core/request/product_request/delete_product_in_order_request.dart';
import '../../../core/resources/data_state.dart';
import '../../../data/models/order.dart';
import '../../repositories/product_repository.dart';

@inject.injectable
class DeleteProductInOrderUseCase
    extends UseCase<DataState<Order?>, DeleteProductInOrderRequest> {
  final ProductRepository _repository;

  DeleteProductInOrderUseCase(this._repository);

  @override
  Future<DataState<Order?>> call(
      {required DeleteProductInOrderRequest params}) {
    return _repository.deleteProductInOrder(params);
  }
}
