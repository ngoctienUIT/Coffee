import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/preferences_model.dart';
import 'topping_event.dart';
import 'topping_state.dart';

class ToppingBloc extends Bloc<ToppingEvent, ToppingState> {
  PreferencesModel preferencesModel;

  ToppingBloc(this.preferencesModel) : super(InitState()) {
    on<FetchData>((event, emit) => getData(true, emit));

    on<UpdateData>((event, emit) => getData(false, emit));

    on<PickEvent>((event, emit) => emit(PickState()));

    on<DeleteEvent>((event, emit) => deleteTopping(event.id, emit));
  }

  Future getData(bool check, Emitter emit) async {
    try {
      if (check) emit(ToppingLoading());
      final response = await preferencesModel.apiService.getAllToppings();
      emit(ToppingLoaded(response.data));
    } on DioException catch (e) {
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
      emit(ToppingLoading(false));
      await preferencesModel.apiService
          .removeToppingByID("Bearer ${preferencesModel.token}", id);
      // final response = await apiService.getAllToppings();
      emit(DeleteSuccess(id));
    } on DioException catch (e) {
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
