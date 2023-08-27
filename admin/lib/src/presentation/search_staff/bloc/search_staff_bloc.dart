import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/search_use_case/search_staff.dart';
import 'search_staff_event.dart';
import 'search_staff_state.dart';

class SearchStaffBloc extends Bloc<SearchStaffEvent, SearchStaffState> {
  final SearchStaffUseCase _useCase;

  SearchStaffBloc(this._useCase) : super(InitState()) {
    on<SearchStaff>(_search);
  }

  Future _search(SearchStaff event, Emitter emit) async {
    emit(SearchLoading());
    final response = await _useCase.call(params: event.query);
    if (response is DataSuccess) {
      emit(SearchLoaded(response.data!));
    } else {
      emit(SearchError(response.error));
    }
  }
}
