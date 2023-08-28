import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../core/response/order_response/get_order_response.dart';
import '../../repositories/order_repository.dart';

@lazySingleton
class GetOrderByIDUseCase extends UseCase<DataState<GetOrderResponse>, String> {
  final OrderRepository _repository;

  GetOrderByIDUseCase(this._repository);

  @override
  Future<DataState<GetOrderResponse>> call({required String params}) {
    return _repository.getOrderByID(params);
  }
}
