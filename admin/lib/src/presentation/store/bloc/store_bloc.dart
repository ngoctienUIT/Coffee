import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/store_use_case/delete_store.dart';
import '../../../domain/use_cases/store_use_case/get_store.dart';
import 'store_event.dart';
import 'store_state.dart';

@injectable
class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final DeleteStoreUseCase _deleteStoreUseCase;
  final GetStoreUseCase _getStoreUseCase;

  StoreBloc(this._deleteStoreUseCase, this._getStoreUseCase)
      : super(InitState()) {
    on<FetchData>((event, emit) => getData(true, "", emit));

    on<UpdateData>((event, emit) => getData(false, event.query, emit));

    on<DeleteEvent>(_deleteStore);

    on<SearchStore>(_searchStore);
  }

  Future getData(bool check, String query, Emitter emit) async {
    if (check) emit(StoreLoading());
    final response = await _getStoreUseCase.call(params: query);
    if (response is DataSuccess) {
      emit(StoreLoaded(response.data!));
    } else {
      emit(StoreError(response.error));
    }
  }

  Future _deleteStore(DeleteEvent event, Emitter emit) async {
    emit(StoreLoading(false));
    final response = await _deleteStoreUseCase.call(params: event.id);
    if (response is DataSuccess) {
      emit(DeleteSuccess(event.id));
    } else {
      emit(StoreError(response.error));
    }
  }

  Future _searchStore(SearchStore event, Emitter emit) async {
    emit(StoreLoading());
    final response = await _getStoreUseCase.call(params: event.storeName);
    if (response is DataSuccess) {
      emit(StoreLoaded(response.data!));
    } else {
      emit(StoreError(response.error));
    }
  }
}
