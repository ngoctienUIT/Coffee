import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service.dart';
import 'topping_event.dart';
import 'topping_state.dart';

class ToppingBloc extends Bloc<ToppingEvent, ToppingState> {
  ToppingBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getData(emit));

    on<PickEvent>((event, emit) => emit(PickState()));

    on<DeleteEvent>((event, emit) => deleteTopping(event.id, emit));
  }

  Future getData(Emitter emit) async {
    try {
      emit(ToppingLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.getAllToppings();
      emit(ToppingLoaded(response.data));
    } on DioError catch (e) {
      if (e.response != null) {
        String error = e.response!.data.toString();
        Fluttertoast.showToast(msg: error);
        emit(ToppingError(error));
        print(error);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      emit(ToppingError(e.toString()));
      print(e);
    }
  }

  Future deleteTopping(String id, Emitter emit) async {
    try {
      emit(ToppingLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      await apiService.removeToppingByID("Bearer $token", id);
      final response = await apiService.getAllToppings();
      emit(ToppingLoaded(response.data));
    } on DioError catch (e) {
      if (e.response != null) {
        String error = e.response!.data.toString();
        Fluttertoast.showToast(msg: error);
        emit(ToppingError(error));
        print(error);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      emit(ToppingError(e.toString()));
      print(e);
    }
  }
}
