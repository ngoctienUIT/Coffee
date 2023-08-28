import '../../core/request/product_request/delete_product_request.dart';
import '../../core/request/product_request/product_request.dart';
import '../../core/resources/data_state.dart';
import '../../data/remote/response/product/product_response.dart';

abstract class ProductRepository {
  Future<DataState<List<ProductResponse>>>
      getAllProductsFromProductCatalogueID(String id);

  Future<DataState<ProductResponse>> createProduct(ProductRequest request);

  Future<DataState<ProductResponse>> updateProduct(ProductRequest request);

  Future<DataState<ProductResponse>> deleteProduct(DeleteProductRequest request);
}
