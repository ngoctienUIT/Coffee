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

    on<RefreshData>((event, emit) => getDataAccount(event.index, emit));
  }

  Future getData(Emitter emit) async {
    try {
      emit(AccountLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      final response = await apiService.getAllUsers('Bearer $token');
      final listAccount = response.data
          .where((element) =>
              element.userRole == "ADMIN" || element.userRole == "STAFF")
          .toList();

      emit(AccountLoaded(0, listAccount));
    } catch (e) {
      emit(AccountError(serverStatus(e)!));
      print(e);
    }
  }

  Future getDataAccount(int index, Emitter emit) async {
    try {
      emit(RefreshLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      String status = index == 0 ? "" : (index == 1 ? "ADMIN" : "STAFF");
      final response = await apiService.getAllUsers('Bearer $token');
      final listAccount = index == 0
          ? response.data
          : response.data
              .where((element) => element.userRole == status)
              .toList();

      emit(RefreshLoaded(index, listAccount));
    } catch (e) {
      emit(RefreshError(serverStatus(e)!));
      print(e);
    }
  }
}
