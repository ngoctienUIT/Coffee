import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/topping_use_case/delete_topping.dart';
import '../../../domain/use_cases/topping_use_case/get_topping.dart';
import 'topping_event.dart';
import 'topping_state.dart';

@injectable
class ToppingBloc extends Bloc<ToppingEvent, ToppingState> {
  final GetToppingUseCase _getToppingUseCase;
  final DeleteToppingUseCase _deleteToppingUseCase;

  ToppingBloc(
    this._getToppingUseCase,
    this._deleteToppingUseCase,
  ) : super(InitState()) {
    on<FetchData>((event, emit) => getData(true, emit));

    on<UpdateData>((event, emit) => getData(false, emit));

    on<PickEvent>((event, emit) => emit(PickState()));

    on<DeleteEvent>(_deleteTopping);
  }

  Future getData(bool check, Emitter emit) async {
    if (check) emit(ToppingLoading());
    final response = await _getToppingUseCase.call();
    if (response is DataSuccess) {
      emit(ToppingLoaded(response.data!));
    } else {
      emit(ToppingError(response.error));
    }
  }

  Future _deleteTopping(DeleteEvent event, Emitter emit) async {
    emit(ToppingLoading(false));
    final response = await _deleteToppingUseCase.call(params: event.id);
    if (response is DataSuccess) {
      emit(DeleteSuccess(event.id));
    } else {
      emit(ToppingError(response.error));
    }
  }
}
