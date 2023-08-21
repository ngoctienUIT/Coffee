import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/order/order_response.dart';
import '../../repositories/cart_repository.dart';

@lazySingleton
class DeleteProductUseCase extends UseCase<DataState<OrderResponse?>, int> {
  final CartRepository _repository;

  DeleteProductUseCase(this._repository);

  @override
  Future<DataState<OrderResponse?>> call({required int params}) {
    return _repository.deleteProduct(params);
  }
}
