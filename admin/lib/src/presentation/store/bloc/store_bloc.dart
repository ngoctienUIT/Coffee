import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/preferences_model.dart';
import '../../../domain/api_service.dart';
import 'store_event.dart';
import 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  PreferencesModel preferencesModel;

  StoreBloc(this.preferencesModel) : super(InitState()) {
    on<FetchData>((event, emit) => getData(true, "", emit));

    on<UpdateData>((event, emit) => getData(false, event.query, emit));

    on<DeleteEvent>((event, emit) => deleteStore(event.id, emit));

    on<SearchStore>((event, emit) => searchStore(emit, event.storeName));
  }

  Future getData(bool check, String query, Emitter emit) async {
    try {
      if (check) emit(StoreLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      // final response = await apiService.getAllStores();
      final response = await apiService.searchStoresByName(query);
      emit(StoreLoaded(response.data));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(StoreError(error));
      print(error);
    } catch (e) {
      emit(StoreError(e.toString()));
      print(e);
    }
  }

  Future deleteStore(String id, Emitter emit) async {
    try {
      emit(StoreLoading(false));
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      await apiService.removeStoreByID(id, "Bearer ${preferencesModel.token}");
      // final response = await apiService.searchStoresByName(query);
      emit(DeleteSuccess(id));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(StoreError(error));
      print(error);
    } catch (e) {
      emit(StoreError(e.toString()));
      print(e);
    }
  }

  Future searchStore(Emitter emit, String query) async {
    try {
      emit(StoreLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.searchStoresByName(query);
      emit(StoreLoaded(response.data));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(StoreError(error));
      print(error);
    } catch (e) {
      emit(StoreError(e.toString()));
      print(e);
    }
  }
}
