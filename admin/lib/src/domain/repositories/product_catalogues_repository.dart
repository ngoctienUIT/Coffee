import 'package:coffee_admin/src/core/resources/data_state.dart';

import '../../core/request/product_catalogues_request/product_catalogues_request.dart';
import '../../data/remote/response/product_catalogues/product_catalogues_response.dart';

abstract class ProductCataloguesRepository {
  Future<DataState<List<ProductCataloguesResponse>>> getAllProductCatalogues();

  Future<DataState<ProductCataloguesResponse>> createProductCatalogues(
      ProductCataloguesRequest request);

  Future<DataState<ProductCataloguesResponse>> updateProductCatalogues(
      ProductCataloguesRequest request);

  Future<DataState<ProductCataloguesResponse>> deleteProductCatalogues(String id);
}
