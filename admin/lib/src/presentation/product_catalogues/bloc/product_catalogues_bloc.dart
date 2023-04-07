import 'package:coffee_admin/src/presentation/product_catalogues/bloc/product_catalogues_event.dart';
import 'package:coffee_admin/src/presentation/product_catalogues/bloc/product_catalogues_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/server_status.dart';
import '../../../domain/api_service.dart';

class ProductCataloguesBloc
    extends Bloc<ProductCataloguesEvent, ProductCataloguesState> {
  ProductCataloguesBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getData(emit));

    on<DeleteEvent>((event, emit) => deleteProductCatalogues(event.id, emit));
  }

  Future getData(Emitter emit) async {
    try {
      emit(ProductCataloguesLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.getAllProductCatalogues();
      emit(ProductCataloguesLoaded(response.data));
    } catch (e) {
      emit(ProductCataloguesError(serverStatus(e)!));
      print(e);
    }
  }

  Future deleteProductCatalogues(String id, Emitter emit) async {
    try {
      emit(ProductCataloguesLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      await apiService.removeProductCataloguesByID("Bearer $token", id);
      final response = await apiService.getAllProductCatalogues();
      emit(ProductCataloguesLoaded(response.data));
    } catch (e) {
      emit(ProductCataloguesError(serverStatus(e)!));
      print(e);
    }
  }
}
