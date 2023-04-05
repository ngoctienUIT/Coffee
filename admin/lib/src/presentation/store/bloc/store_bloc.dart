import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/server_status.dart';
import '../../../domain/api_service.dart';
import 'store_event.dart';
import 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getData(emit));

    on<SearchStore>((event, emit) => searchStore(emit, event.storeName));
  }

  Future getData(Emitter emit) async {
    try {
      emit(StoreLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.getAllStores();
      emit(StoreLoaded(response.data));
    } catch (e) {
      emit(StoreError(serverStatus(e)!));
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
    } catch (e) {
      emit(StoreError(serverStatus(e)!));
      print(e);
    }
  }
}
