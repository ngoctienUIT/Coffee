import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/search_use_case/search_product.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchProductUseCase _useCase;

  SearchBloc(this._useCase) : super(InitState()) {
    on<SearchProduct>(_search);
  }

  Future _search(SearchProduct event, Emitter emit) async {
    emit(SearchLoading());
    final response = await _useCase.call(params: event.query);
    if (response is DataSuccess) {
      emit(SearchLoaded(response.data!));
    } else {
      emit(SearchError(response.error));
    }
  }
}
