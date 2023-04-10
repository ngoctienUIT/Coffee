import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/server_status.dart';
import '../../../domain/api_service.dart';
import 'account_event.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getData(emit));

    on<DeleteEvent>(
        (event, emit) => deleteAccount(event.id, event.index, emit));

    on<RefreshData>((event, emit) => getDataAccount(event.index, emit));
  }

  Future getData(Emitter emit) async {
    try {
      emit(AccountLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "admin";
      final response = await apiService.getAllUsers('Bearer $token');
      final listAccount = response.data
          .where((element) =>
              element.email != email &&
              (element.userRole == "ADMIN" || element.userRole == "STAFF"))
          .toList();

      emit(AccountLoaded(0, listAccount));
    } catch (e) {
      emit(AccountError(serverStatus(e)!));
      print(e);
    }
  }

  Future getDataAccount(int index, Emitter emit) async {
    try {
      emit(AccountLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "admin";
      String status = index == 0 ? "" : (index == 1 ? "ADMIN" : "STAFF");
      final response = await apiService.getAllUsers('Bearer $token');
      final listAccount = index == 0
          ? response.data
              .where((element) =>
                  element.email != email &&
                  (element.userRole == "ADMIN" || element.userRole == "STAFF"))
              .toList()
          : response.data
              .where((element) =>
                  element.email != email && element.userRole == status)
              .toList();

      emit(AccountLoaded(index, listAccount));
    } catch (e) {
      emit(AccountError(serverStatus(e)!));
      print(e);
    }
  }

  Future deleteAccount(String id, int index, Emitter emit) async {
    try {
      emit(AccountLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String email = prefs.getString("username") ?? "admin";
      String status = index == 0 ? "" : (index == 1 ? "ADMIN" : "STAFF");
      apiService.removeUserByID(id);
      final response = await apiService.getAllUsers('Bearer $token');
      final listAccount = index == 0
          ? response.data
              .where((element) =>
                  element.email != email &&
                  (element.userRole == "ADMIN" || element.userRole == "STAFF"))
              .toList()
          : response.data
              .where((element) =>
                  element.email != email && element.userRole == status)
              .toList();

      emit(AccountLoaded(index, listAccount));
    } catch (e) {
      emit(AccountError(serverStatus(e)!));
      print(e);
    }
  }
}
