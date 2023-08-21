import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/order/order_response.dart';
import '../../repositories/cart_repository.dart';

@lazySingleton
class PlaceOrderUseCase extends UseCase<DataState<OrderResponse>, dynamic> {
  final CartRepository _repository;

  PlaceOrderUseCase(this._repository);

  @override
  Future<DataState<OrderResponse>> call({params}) {
    return _repository.placeOrder();
  }
}
