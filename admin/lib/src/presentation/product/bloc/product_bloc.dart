import 'package:coffee_admin/src/presentation/product/bloc/product_event.dart';
import 'package:coffee_admin/src/presentation/product/bloc/product_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service.dart';
import '../../../domain/repositories/product_catalogues/product_catalogues_response.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  List<ProductCataloguesResponse> listProductCatalogues = [];

  ProductBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getData(emit));

    on<RefreshData>((event, emit) => getDataProduct(event.index, emit));

    on<UpdateData>((event, emit) => updateDataProduct(event.index, emit));

    on<DeleteEvent>(
        (event, emit) => deleteProduct(event.id, event.index, emit));
  }

  Future getData(Emitter emit) async {
    try {
      emit(ProductLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.getAllProductCatalogues();
      listProductCatalogues = response.data;
      final productResponse = await apiService
          .getAllProductsFromProductCatalogueID(listProductCatalogues[0].id);
      final listProduct = productResponse.data;
      emit(ProductLoaded(0, listProduct, listProductCatalogues));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ProductError(error));
      print(error);
    } catch (e) {
      emit(ProductError(e.toString()));
      print(e);
    }
  }

  Future getDataProduct(int index, Emitter emit) async {
    try {
      emit(RefreshLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.getAllProductsFromProductCatalogueID(
          listProductCatalogues[index].id);
      final listProduct = response.data;

      emit(RefreshLoaded(index, listProduct));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(RefreshError(error));
      print(error);
    } catch (e) {
      emit(RefreshError(e.toString()));
      print(e);
    }
  }

  Future updateDataProduct(int index, Emitter emit) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.getAllProductsFromProductCatalogueID(
          listProductCatalogues[index].id);
      final listProduct = response.data;

      emit(RefreshLoaded(index, listProduct));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(RefreshError(error));
      print(error);
    } catch (e) {
      emit(RefreshError(e.toString()));
      print(e);
    }
  }

  Future deleteProduct(String id, int index, Emitter emit) async {
    try {
      emit(RefreshLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      await apiService.removeProductByID('Bearer $token', id);
      final catalogueResponse = await apiService
          .getProductCatalogueByID(listProductCatalogues[index].id);
      List<String> list = catalogueResponse.data.associatedProductIds!;
      list.remove(id);
      await apiService.updateProductIdsProductCatalogues(
          'Bearer $token', list, listProductCatalogues[index].id);
      final response = await apiService.getAllProductsFromProductCatalogueID(
          listProductCatalogues[index].id);
      emit(RefreshLoaded(index, response.data));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(RefreshError(error));
      print(error);
    } catch (e) {
      emit(RefreshError(e.toString()));
      print(e);
    }
  }
}
