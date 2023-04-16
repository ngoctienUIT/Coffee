import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/order.dart';
import '../../../domain/api_service.dart';
import 'store_event.dart';
import 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getData(emit));

    on<UpdateStoreOrder>((event, emit) => updateStoreOrder());

    on<SearchStore>((event, emit) => searchStore(emit, event.storeName));
  }

  Future getData(Emitter emit) async {
    try {
      emit(StoreLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String id = prefs.getString("storeID") ?? "";
      final response = await apiService.getAllStores();
      emit(StoreLoaded(response.data, id));
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

  Future updateStoreOrder() async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "";
      String storeID = prefs.getString("storeID") ?? "";

      final response =
          await apiService.getAllOrders("Bearer $token", email, "PENDING");
      if (response.data.isNotEmpty) {
        Order order = Order.fromOrderResponse(response.data[0]);
        if (order.selectedPickupOption == "AT_STORE") {
          if (storeID.isEmpty) {
            storeID = "6425d2c7cf1d264dca4bcc82";
            prefs.setString("storeID", "6425d2c7cf1d264dca4bcc82");
          }
          order.storeId = storeID;
        }
        await apiService.updatePendingOrder(
            "Bearer $token", order.toJson(), order.orderId!);
      }
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      Fluttertoast.showToast(msg: error);
      print(error);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      print(e);
    }
  }

  Future searchStore(Emitter emit, String query) async {
    try {
      emit(StoreLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String id = prefs.getString("storeID") ?? "";
      final response = await apiService.searchStoresByName(query);

      emit(StoreLoaded(response.data, id));
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
