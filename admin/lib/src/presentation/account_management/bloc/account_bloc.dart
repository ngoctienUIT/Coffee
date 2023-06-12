import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/preferences_model.dart';
import '../../../domain/api_service.dart';
import 'account_event.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  PreferencesModel preferencesModel;

  AccountBloc(this.preferencesModel) : super(InitState()) {
    on<FetchData>((event, emit) => getData(emit));

    on<UpdateData>((event, emit) => getDataAccount(false, event.index, emit));

    on<DeleteEvent>(
        (event, emit) => deleteAccount(event.id, event.index, emit));

    on<RefreshData>((event, emit) => getDataAccount(true, event.index, emit));
  }

  Future getData(Emitter emit) async {
    try {
      emit(AccountLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response =
          await apiService.getAllUsers('Bearer ${preferencesModel.token}');
      final listAccount = response.data
          .where((element) =>
              element.email != preferencesModel.user!.email &&
              (element.userRole == "ADMIN" || element.userRole == "STAFF"))
          .toList();

      emit(AccountLoaded(0, listAccount));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(AccountError(error));
      print(error);
    } catch (e) {
      emit(AccountError(e.toString()));
      print(e);
    }
  }

  Future getDataAccount(bool check, int index, Emitter emit) async {
    try {
      if (check) emit(AccountLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      String status = index == 0 ? "" : (index == 1 ? "ADMIN" : "STAFF");
      final response =
          await apiService.getAllUsers('Bearer ${preferencesModel.token}');
      final listAccount = index == 0
          ? response.data
              .where((element) =>
                  element.email != preferencesModel.user!.email &&
                  (element.userRole == "ADMIN" || element.userRole == "STAFF"))
              .toList()
          : response.data
              .where((element) =>
                  element.email != preferencesModel.user!.email &&
                  element.userRole == status)
              .toList();

      emit(AccountLoaded(index, listAccount));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(AccountError(error));
      print(error);
    } catch (e) {
      emit(AccountError(e.toString()));
      print(e);
    }
  }

  Future deleteAccount(String id, int index, Emitter emit) async {
    try {
      emit(AccountLoading(false));
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      String status = index == 0 ? "" : (index == 1 ? "ADMIN" : "STAFF");
      await apiService.removeUserByID('Bearer ${preferencesModel.token}', id);
      final response =
          await apiService.getAllUsers('Bearer ${preferencesModel.token}');
      final listAccount = index == 0
          ? response.data
              .where((element) =>
                  element.email != preferencesModel.user!.email &&
                  (element.userRole == "ADMIN" || element.userRole == "STAFF"))
              .toList()
          : response.data
              .where((element) =>
                  element.email != preferencesModel.user!.email &&
                  element.userRole == status)
              .toList();

      emit(AccountLoaded(index, listAccount, false));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(AccountError(error));
      print(error);
    } catch (e) {
      emit(AccountError(e.toString()));
      print(e);
    }
  }
}
