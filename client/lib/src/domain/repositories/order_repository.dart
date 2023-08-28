import '../../core/resources/data_state.dart';
import '../../data/remote/response/product/product_response.dart';
import '../../data/remote/response/product_catalogues/product_catalogues_response.dart';

abstract class OrderRepository {
  Future<DataState<List<ProductCataloguesResponse>>> getProductCatalogues();

  Future<DataState<List<ProductResponse>>> getListProduct(String id);
}
