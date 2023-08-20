import 'package:coffee/src/core/resources/data_state.dart';

import '../../data/remote/response/product/product_response.dart';

abstract class SearchRepository {
  Future<DataState<List<ProductResponse>>> search(String query);
}
