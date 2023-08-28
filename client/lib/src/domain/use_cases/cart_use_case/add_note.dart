import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/order/order_response.dart';
import '../../repositories/cart_repository.dart';

@lazySingleton
class AddNoteUseCase extends UseCase<DataState<OrderResponse>, String> {
  final CartRepository _repository;

  AddNoteUseCase(this._repository);

  @override
  Future<DataState<OrderResponse>> call({required String params}) {
    return _repository.addNote(params);
  }
}
