import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/preferences_model.dart';
import 'search_staff_event.dart';
import 'search_staff_state.dart';

class SearchStaffBloc extends Bloc<SearchStaffEvent, SearchStaffState> {
  PreferencesModel preferencesModel;

  SearchStaffBloc(this.preferencesModel) : super(InitState()) {
    on<SearchStaff>((event, emit) => search(event.query, emit));
  }

  Future search(String query, Emitter emit) async {
    try {
      emit(SearchLoading());
      final response =
          await preferencesModel.apiService.searchUserByName(query);
      final listAccount = response.data
          .where((element) =>
              element.email != preferencesModel.user!.email &&
              (element.userRole == "ADMIN" || element.userRole == "STAFF"))
          .toList();
      emit(SearchLoaded(listAccount));
    } on DioException catch (e) {
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
