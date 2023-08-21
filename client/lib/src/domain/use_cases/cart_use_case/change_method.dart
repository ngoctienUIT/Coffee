import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/request/cart_request/change_method_request.dart';
import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/order/order_response.dart';
import '../../repositories/cart_repository.dart';

@lazySingleton
class ChangeMethodUseCase
    extends UseCase<DataState<OrderResponse>, ChangeMethodRequest> {
  final CartRepository _repository;

  ChangeMethodUseCase(this._repository);

  @override
  Future<DataState<OrderResponse>> call({required ChangeMethodRequest params}) {
    return _repository.changeMethod(params);
  }
}
