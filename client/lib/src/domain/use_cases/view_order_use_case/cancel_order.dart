import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:coffee/src/domain/repositories/view_order_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/order/order_response.dart';

@lazySingleton
class CancelOrderUseCase extends UseCase<DataState<OrderResponse>, String> {
  CancelOrderUseCase(this._repository);

  final ViewOrderRepository _repository;

  @override
  Future<DataState<OrderResponse>> call({required String params}) {
    return _repository.cancelOrder(params);
  }
}
