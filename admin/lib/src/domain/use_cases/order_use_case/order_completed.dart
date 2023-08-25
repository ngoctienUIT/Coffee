import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/request/order_request/order_request.dart';
import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/order/order_response.dart';
import '../../repositories/order_repository.dart';

@lazySingleton
class OrderCompletedUseCase
    extends UseCase<DataState<OrderResponse>, OrderRequest> {
  final OrderRepository _repository;

  OrderCompletedUseCase(this._repository);

  @override
  Future<DataState<OrderResponse>> call({required OrderRequest params}) {
    return _repository.orderCompleted(params);
  }
}
