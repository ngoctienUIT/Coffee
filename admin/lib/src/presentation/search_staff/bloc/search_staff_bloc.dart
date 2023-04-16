import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/api_service.dart';
import 'search_staff_event.dart';
import 'search_staff_state.dart';

class SearchStaffBloc extends Bloc<SearchStaffEvent, SearchStaffState> {
  SearchStaffBloc() : super(InitState()) {
    on<SearchStaff>((event, emit) => search(event.query, emit));
  }

  Future search(String query, Emitter emit) async {
    try {
      emit(SearchLoading());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.searchUserByName(query);
      emit(SearchLoaded(response.data));
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(SearchError(error));
      print(error);
    } catch (e) {
      emit(SearchError(e.toString()));
      print(e);
    }
  }
}
