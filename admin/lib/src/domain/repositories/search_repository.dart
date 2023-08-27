import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/data/remote/response/product/product_response.dart';

import '../../data/remote/response/user/user_response.dart';

abstract class SearchRepository {
  Future<DataState<List<ProductResponse>>> searchProduct(String query);

  Future<DataState<List<UserResponse>>> searchStaff(String query);
}
