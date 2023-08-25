import '../../core/request/topping_request/topping_request.dart';
import '../../core/resources/data_state.dart';
import '../../data/remote/response/topping/topping_response.dart';

abstract class ToppingRepository {
  Future<DataState<List<ToppingResponse>>> getTopping();

  Future<DataState<ToppingResponse>> createTopping(ToppingRequest request);

  Future<DataState<ToppingResponse>> updateTopping(ToppingRequest request);

  Future<DataState<ToppingResponse>> deleteTopping(String id);
}
