import 'package:coffee_admin/src/presentation/product/bloc/product_event.dart';
import 'package:coffee_admin/src/presentation/product/bloc/product_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/api_service.dart';
import '../../../domain/repositories/product_catalogues/product_catalogues_response.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  List<ProductCataloguesResponse> listProductCatalogues = [];

  ProductBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getData(emit));

    on<RefreshData>((event, emit) => getDataProduct(event.index, emit));
  }

  Future getData(Emitter emit) async {
    try {
      emit(ProductLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      listProductCatalogues = await apiService.getAllProductCatalogues();
      final listProduct = await apiService
          .getAllProductsFromProductCatalogueID(listProductCatalogues[0].id);

      emit(ProductLoaded(0, listProduct, listProductCatalogues));
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
      final listProduct = await apiService.getAllProductsFromProductCatalogueID(
          listProductCatalogues[index].id);

      emit(RefreshLoaded(index, listProduct));
    } catch (e) {
      emit(RefreshError(e.toString()));
      print(e);
    }
  }
}
