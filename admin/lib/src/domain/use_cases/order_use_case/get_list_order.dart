import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/order/order_response.dart';
import '../../repositories/order_repository.dart';

@lazySingleton
class GetListOrderUseCase
    extends UseCase<DataState<List<OrderResponse>>, String> {
  final OrderRepository _repository;

  GetListOrderUseCase(this._repository);

  @override
  Future<DataState<List<OrderResponse>>> call({required String params}) {
    return _repository.getListOrder(params);
  }
}
