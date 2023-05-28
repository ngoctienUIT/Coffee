import 'package:coffee_admin/src/presentation/product_catalogues/bloc/product_catalogues_event.dart';
import 'package:coffee_admin/src/presentation/product_catalogues/bloc/product_catalogues_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/preferences_model.dart';
import '../../../domain/api_service.dart';

class ProductCataloguesBloc
    extends Bloc<ProductCataloguesEvent, ProductCataloguesState> {
  PreferencesModel preferencesModel;

  ProductCataloguesBloc(this.preferencesModel) : super(InitState()) {
    on<FetchData>((event, emit) => getData(true, emit));

    on<UpdateData>((event, emit) => getData(false, emit));

    on<DeleteEvent>((event, emit) => deleteProductCatalogues(event.id, emit));
  }

  Future getData(bool check, Emitter emit) async {
    try {
      if (check) emit(ProductCataloguesLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.getAllProductCatalogues();
      emit(ProductCataloguesLoaded(response.data));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ProductCataloguesError(error));
      print(error);
    } catch (e) {
      emit(ProductCataloguesError(e.toString()));
      print(e);
    }
  }

  Future deleteProductCatalogues(String id, Emitter emit) async {
    try {
      emit(ProductCataloguesLoading(false));
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      await apiService.removeProductCataloguesByID(
          "Bearer ${preferencesModel.token}", id);
      // final response = await apiService.getAllProductCatalogues();
      emit(DeleteSuccess(id));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ProductCataloguesError(error));
      print(error);
    } catch (e) {
      emit(ProductCataloguesError(e.toString()));
      print(e);
    }
  }
}
