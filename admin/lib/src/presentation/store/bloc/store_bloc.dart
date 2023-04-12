import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service.dart';
import 'store_event.dart';
import 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getData(emit));

    on<DeleteEvent>((event, emit) => deleteStore(event.id, event.query, emit));

    on<SearchStore>((event, emit) => searchStore(emit, event.storeName));
  }

  Future getData(Emitter emit) async {
    try {
      emit(StoreLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.getAllStores();
      emit(StoreLoaded(response.data));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      Fluttertoast.showToast(msg: error);
      emit(StoreError(error));
      print(error);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      emit(StoreError(e.toString()));
      print(e);
    }
  }

  Future deleteStore(String id, String query, Emitter emit) async {
    try {
      emit(StoreLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      await apiService.removeStoreByID(id, "Bearer $token");
      final response = await apiService.searchStoresByName(query);
      emit(StoreLoaded(response.data));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      Fluttertoast.showToast(msg: error);
      emit(StoreError(error));
      print(error);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
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
      Fluttertoast.showToast(msg: error);
      emit(StoreError(error));
      print(error);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      emit(StoreError(e.toString()));
      print(e);
    }
  }
}
