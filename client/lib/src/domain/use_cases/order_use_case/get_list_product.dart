import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/product/product_response.dart';
import '../../repositories/order_repository.dart';

@lazySingleton
class GetListProductUseCase
    extends UseCase<DataState<List<ProductResponse>>, String> {
  GetListProductUseCase(this._repository);

  final OrderRepository _repository;

  @override
  Future<DataState<List<ProductResponse>>> call({required String params}) {
    return _repository.getListProduct(params);
  }
}
