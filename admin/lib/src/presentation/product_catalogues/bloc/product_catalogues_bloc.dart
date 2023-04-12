import 'package:coffee_admin/src/presentation/product_catalogues/bloc/product_catalogues_event.dart';
import 'package:coffee_admin/src/presentation/product_catalogues/bloc/product_catalogues_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      Fluttertoast.showToast(msg: error);
      emit(ProductCataloguesError(error));
      print(error);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      emit(ProductCataloguesError(e.toString()));
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
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      Fluttertoast.showToast(msg: error);
      emit(ProductCataloguesError(error));
      print(error);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      emit(ProductCataloguesError(e.toString()));
      print(e);
    }
  }
}
