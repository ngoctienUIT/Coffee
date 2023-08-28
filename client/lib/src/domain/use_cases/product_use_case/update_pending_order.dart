import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart' as inject;

import '../../../core/request/product_request/update_order_request.dart';
import '../../../core/resources/data_state.dart';
import '../../../data/models/order.dart';
import '../../repositories/product_repository.dart';

@inject.lazySingleton
class UpdatePendingOrderUseCase
    extends UseCase<DataState<Order?>, UpdateOrderRequest> {
  final ProductRepository _repository;

  UpdatePendingOrderUseCase(this._repository);

  @override
  Future<DataState<Order?>> call({required UpdateOrderRequest params}) {
    return _repository.updatePendingOrder(params);
  }
}
