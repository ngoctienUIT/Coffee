import 'package:coffee/src/core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/use_cases/store_use_case/get_data_store.dart';
import '../../../domain/use_cases/store_use_case/get_store.dart';
import '../../../domain/use_cases/store_use_case/search_store.dart';
import 'store_event.dart';
import 'store_state.dart';

@injectable
class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final GetDataStoreUseCase _getDataStoreUseCase;
  final GetStoreUseCase _getStoreUseCase;
  final SearchStoreUseCase _searchStoreUseCase;
  final SharedPreferences _prefs;

  StoreBloc(
    this._prefs,
    this._getDataStoreUseCase,
    this._getStoreUseCase,
    this._searchStoreUseCase,
  ) : super(InitState()) {
    on<FetchData>(_getData);

    on<SearchStore>(_searchStore);

    on<RefreshData>(_refreshData);
  }

  Future _getData(FetchData event, Emitter emit) async {
    emit(StoreLoading());
    final response = await _getStoreUseCase.call();
    final storeID = _prefs.getString("storeID");
    if (response is DataSuccess) {
      emit(StoreLoaded(
          response.data!.map((e) => e.toStore()).toList(), storeID ?? ""));
    } else {
      emit(StoreError(response.error));
    }
  }

  Future _refreshData(RefreshData event, Emitter emit) async {
    emit(StoreLoading());
    final response = await _getDataStoreUseCase.call();
    final storeID = _prefs.getString("storeID");
    if (response is DataSuccess) {
      emit(StoreLoaded(
          response.data!.map((e) => e.toStore()).toList(), storeID ?? ""));
    } else {
      emit(StoreError(response.error));
    }
  }

  Future _searchStore(SearchStore event, Emitter emit) async {
    emit(StoreLoading());
    final response = await _searchStoreUseCase.call(params: event.storeName);
    final storeID = _prefs.getString("storeID");
    if (response is DataSuccess) {
      emit(StoreLoaded(
          response.data!.map((e) => e.toStore()).toList(), storeID ?? ""));
    } else {
      emit(StoreError(response.error));
    }
  }
}
