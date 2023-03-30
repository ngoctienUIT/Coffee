import 'package:coffee_admin/src/presentation/product/bloc/product_event.dart';
import 'package:coffee_admin/src/presentation/product/bloc/product_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/api_service.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getData(emit));

    on<RefreshData>((event, emit) => getDataProduct(emit));
  }

  Future getData(Emitter emit) async {
    try {
      emit(ProductLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final listProduct = await apiService.getAllProducts();
      final listProductCatalogues = await apiService.getAllProductCatalogues();

      emit(ProductLoaded(listProduct, listProductCatalogues));
    } catch (e) {
      emit(ProductError(e.toString()));
      print(e);
    }
  }

  Future getDataProduct(Emitter emit) async {
    try {
      emit(RefreshLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final listProduct = await apiService.getAllProducts();

      emit(RefreshLoaded(listProduct));
    } catch (e) {
      emit(RefreshError(e.toString()));
      print(e);
    }
  }
}
