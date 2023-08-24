import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/core/utils/extensions/dio_extension.dart';
import 'package:coffee_admin/src/data/remote/api_service/api_service.dart';

import 'package:coffee_admin/src/data/remote/response/product/product_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/request/product_request/delete_product_request.dart';
import '../../core/request/product_request/product_request.dart';
import '../../domain/repositories/product_repository.dart';
import '../remote/firebase/firebase_service.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl extends ProductRepository {
  final ApiService _apiService;
  final SharedPreferences _sharedPref;

  ProductRepositoryImpl(this._apiService, this._sharedPref);

  @override
  Future<DataState<ProductResponse>> createProduct(
      ProductRequest request) async {
    try {
      final token = _sharedPref.get("token") ?? "";
      if (request.image.isNotEmpty) {
        request.product.image = await uploadImage(
          folder: "product",
          name: request.image.split("/").last,
          image: request.image,
        );
      }
      final catalogueResponse =
          await _apiService.getProductCatalogueByID(request.catalogueID!);
      final response = await _apiService.createNewProduct(
          'Bearer $token', request.product.toJson());
      List<String> list = catalogueResponse.data.associatedProductIds!;
      list.add(response.data.id);
      await _apiService.updateProductIdsProductCatalogues(
          'Bearer $token', list, request.catalogueID!);
      return DataSuccess(response.data);
    } on DioException catch (e) {
      String error = e.getError();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<ProductResponse>> deleteProduct(
      DeleteProductRequest request) async {
    try {
      final token = _sharedPref.get("token") ?? "";
      final catalogueResponse = await _apiService
          .getProductCatalogueByID(request.productCataloguesID);
      List<String> list = catalogueResponse.data.associatedProductIds!;
      list.remove(request.productID);
      await _apiService.updateProductIdsProductCatalogues(
          'Bearer $token', list, request.productCataloguesID);
      final response = await _apiService.removeProductByID(
          'Bearer $token', request.productID);
      return DataSuccess(response.data);
    } on DioException catch (e) {
      String error = e.getError();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<List<ProductResponse>>> getAllProductsFromProductCatalogueID(
      String id) async {
    try {
      final response =
          await _apiService.getAllProductsFromProductCatalogueID(id);
      return DataSuccess(response.data);
    } on DioException catch (e) {
      String error = e.getError();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<ProductResponse>> updateProduct(
      ProductRequest request) async {
    try {
      final token = _sharedPref.get("token") ?? "";
      if (request.image.isNotEmpty) {
        request.product.image = await uploadImage(
          folder: "product",
          name: request.image.split("/").last,
          image: request.image,
        );
      }
      final response = await _apiService.updateExistingProducts(
          request.product.id!, 'Bearer $token', request.product.toJson());
      return DataSuccess(response.data);
    } on DioException catch (e) {
      String error = e.getError();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }
}
