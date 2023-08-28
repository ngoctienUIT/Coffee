import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/order/order_response.dart';
import '../../repositories/home_repository.dart';

@lazySingleton
class GetOrderSpendingUseCase
    extends UseCase<DataState<OrderResponse?>, dynamic> {
  GetOrderSpendingUseCase(this._repository);

  final HomeRepository _repository;

  @override
  Future<DataState<OrderResponse?>> call({params}) {
    return _repository.getOrderSpending();
  }
}
