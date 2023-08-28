import 'package:coffee/src/core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/search_use_case/search.dart';
import 'search_event.dart';
import 'search_state.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUseCase _useCase;

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
