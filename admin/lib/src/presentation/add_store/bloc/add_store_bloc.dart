import 'package:coffee_admin/src/core/request/store_request/store_request.dart';
import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/store_use_case/create_store.dart';
import '../../../domain/use_cases/store_use_case/update_store.dart';
import 'add_store_event.dart';
import 'add_store_state.dart';

@injectable
class AddStoreBloc extends Bloc<AddStoreEvent, AddStoreState> {
  String image = "";
  final CreateStoreUseCase _createStoreUseCase;
  final UpdateStoreUseCase _updateStoreUseCase;

  AddStoreBloc(this._createStoreUseCase, this._updateStoreUseCase)
      : super(InitState()) {
    on<ChangeImageEvent>((event, emit) {
      image = event.image;
      emit(ChangeImageState());
    });

    on<ChangeAddressEvent>((event, emit) => emit(ChangeAddressState()));

    on<ChangeCloseEvent>((event, emit) => emit(ChangeCloseState()));

    on<ChangeOpenEvent>((event, emit) => emit(ChangeOpenState()));

    on<SaveButtonEvent>(
        (event, emit) => emit(SaveButtonState(event.isContinue)));

    on<CreateStoreEvent>(_createStore);

    on<UpdateStoreEvent>(_updateStore);
  }

  Future _createStore(CreateStoreEvent event, Emitter emit) async {
    emit(AddStoreLoadingState());
    final response = await _createStoreUseCase.call(
        params: StoreRequest(store: event.store, image: image));
    if (response is DataSuccess) {
      emit(AddStoreSuccessState());
    } else {
      emit(AddStoreErrorState(response.error ?? ""));
    }
  }

  Future _updateStore(UpdateStoreEvent event, Emitter emit) async {
    emit(AddStoreLoadingState());
    final response = await _updateStoreUseCase.call(
        params: StoreRequest(store: event.store, image: image));
    if (response is DataSuccess) {
      emit(AddStoreSuccessState());
    } else {
      emit(AddStoreErrorState(response.error ?? ""));
    }
  }
}
