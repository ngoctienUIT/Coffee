import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/order.dart';
import '../../../data/models/preferences_model.dart';
import '../../../data/models/store.dart';
import '../../../domain/api_service.dart';
import 'store_event.dart';
import 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  PreferencesModel preferencesModel;

  StoreBloc(this.preferencesModel) : super(InitState()) {
    on<FetchData>((event, emit) => getData(emit));

    on<UpdateStoreOrder>((event, emit) => updateStoreOrder());

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
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.getAllStores();
      if (response.data.length != preferencesModel.listStore.length) {
        emit(StoreLoaded(
          response.data.map((e) => Store.fromStoreResponse(e)).toList(),
          preferencesModel.storeID ?? "",
        ));
      }
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

  Future updateStoreOrder() async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      // final prefs = await SharedPreferences.getInstance();
      // String token = prefs.getString("token") ?? "";
      // String email = prefs.getString("username") ?? "";
      // String storeID = prefs.getString("storeID") ?? "";

      final response = await apiService.getAllOrders(
        "Bearer ${preferencesModel.token}",
        preferencesModel.user!.username,
        "PENDING",
      );
      String storeID = preferencesModel.storeID ?? "";
      if (response.data.isNotEmpty) {
        Order order = Order.fromOrderResponse(response.data[0]);
        if (order.selectedPickupOption == "AT_STORE") {
          if (storeID.isEmpty) {
            storeID = "6425d2c7cf1d264dca4bcc82";
            SharedPreferences.getInstance().then((value) {
              value.setString("storeID", "6425d2c7cf1d264dca4bcc82");
            });
          }
          order.storeId = storeID;
        }
        await apiService.updatePendingOrder(
            "Bearer ${preferencesModel.token}", order.toJson(), order.orderId!);
      }
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      print(error);
    } catch (e) {
      print(e);
    }
  }

  Future searchStore(Emitter emit, String query) async {
    try {
      emit(StoreLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.searchStoresByName(query);

      emit(StoreLoaded(
        response.data.map((e) => Store.fromStoreResponse(e)).toList(),
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
