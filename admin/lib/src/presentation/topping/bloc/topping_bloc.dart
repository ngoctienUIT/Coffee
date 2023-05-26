import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/preferences_model.dart';
import '../../../domain/api_service.dart';
import 'topping_event.dart';
import 'topping_state.dart';

class ToppingBloc extends Bloc<ToppingEvent, ToppingState> {
  PreferencesModel preferencesModel;

  ToppingBloc(this.preferencesModel) : super(InitState()) {
    on<FetchData>((event, emit) => getData(emit));

    on<UpdateData>((event, emit) => updateData(emit));

    on<PickEvent>((event, emit) => emit(PickState()));

    on<DeleteEvent>((event, emit) => deleteTopping(event.id, emit));
  }

  Future updateData(Emitter emit) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.getAllToppings();
      emit(ToppingLoaded(response.data));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ToppingError(error));
    } catch (e) {
      emit(ToppingError(e.toString()));
      print(e);
    }
  }

  Future getData(Emitter emit) async {
    try {
      emit(ToppingLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.getAllToppings();
      emit(ToppingLoaded(response.data));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ToppingError(error));
    } catch (e) {
      emit(ToppingError(e.toString()));
      print(e);
    }
  }

  Future deleteTopping(String id, Emitter emit) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      await apiService.removeToppingByID(
          "Bearer ${preferencesModel.token}", id);
      final response = await apiService.getAllToppings();
      emit(ToppingLoaded(response.data));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(ToppingError(error));
      print(error);
    } catch (e) {
      emit(ToppingError(e.toString()));
      print(e);
    }
  }
}
