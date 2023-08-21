import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:coffee/src/data/models/product.dart';
import 'package:injectable/injectable.dart' as inject;

import '../../../core/resources/data_state.dart';
import '../../../data/models/order.dart';
import '../../repositories/product_repository.dart';

@inject.lazySingleton
class CreateNewOrderUseCase extends UseCase<DataState<Order?>, Product> {
  final ProductRepository _repository;

  CreateNewOrderUseCase(this._repository);

  @override
  Future<DataState<Order?>> call({required Product params}) {
    return _repository.createNewOrder(params);
  }
}
