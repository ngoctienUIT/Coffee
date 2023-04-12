import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service.dart';
import 'other_event.dart';
import 'other_state.dart';

class OtherBloc extends Bloc<OtherEvent, OtherState> {
  OtherBloc() : super(InitState()) {
    on<FetchData>((event, emit) => getUserInfo(emit));

    on<ChangeLanguageEvent>(
        (event, emit) => emit(ChangeLanguageState(language: event.language)));
  }

  Future getUserInfo(Emitter emit) async {
    try {
      emit(OtherLoading());
      var prefs = await SharedPreferences.getInstance();
      String id = prefs.getString("userID") ?? "";
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.getUserByID(id);

      emit(OtherLoaded(response.data));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      Fluttertoast.showToast(msg: error);
      emit(OtherError(error));
      print(error);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      emit(OtherError(e.toString()));
      print(e);
    }
  }
}
