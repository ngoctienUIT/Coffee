import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/preferences_model.dart';
import 'store_event.dart';
import 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  PreferencesModel preferencesModel;

  StoreBloc(this.preferencesModel) : super(InitState()) {
    on<FetchData>((event, emit) => getData(emit));

    on<SearchStore>((event, emit) => searchStore(emit, event.storeName));
  }

  Future getData(Emitter emit) async {
    try {
      if (preferencesModel.listStore.isEmpty) {
        emit(StoreLoading());
      }
      if (preferencesModel.listStore.isNotEmpty) {
        emit(StoreLoaded(
            preferencesModel.listStore, preferencesModel.storeID ?? ""));
      }
      // ApiService apiService =
      //     ApiService(Dio(BaseOptions(contentType: "application/json")));
      // final response = await apiService.getAllStores();
      // if (response.data.length != preferencesModel.listStore.length) {
      //   emit(StoreLoaded(
      //     response.data.map((e) => Store.fromStoreResponse(e)).toList(),
      //     preferencesModel.storeID ?? "",
      //   ));
      // }
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
      // ApiService apiService =
      //     ApiService(Dio(BaseOptions(contentType: "application/json")));
      // final response = await apiService.searchStoresByName(query);
      // emit(StoreLoaded(
      //   response.data.map((e) => Store.fromStoreResponse(e)).toList(),
      //   preferencesModel.storeID ?? "",
      // ));
      emit(StoreLoaded(
        preferencesModel.listStore
            .where(
                (e) => e.storeName!.toUpperCase().contains(query.toUpperCase()))
            .toList(),
        preferencesModel.storeID ?? "",
      ));
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
