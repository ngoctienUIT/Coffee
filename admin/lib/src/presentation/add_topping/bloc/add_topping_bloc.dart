import 'package:coffee_admin/src/core/request/topping_request/topping_request.dart';
import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/topping_use_case/create_topping.dart';
import '../../../domain/use_cases/topping_use_case/update_topping.dart';
import 'add_topping_event.dart';
import 'add_topping_state.dart';

@injectable
class AddToppingBloc extends Bloc<AddToppingEvent, AddToppingState> {
  String image = "";
  final CreateToppingUseCase _createToppingUseCase;
  final UpdateToppingUseCase _updateToppingUseCase;

  AddToppingBloc(this._createToppingUseCase, this._updateToppingUseCase)
      : super(InitState()) {
    on<SaveButtonEvent>(
        (event, emit) => emit(SaveButtonState(event.isContinue)));

    on<ChangeImageEvent>((event, emit) {
      image = event.image;
      emit(ChangeImageState());
    });

    on<CreateToppingEvent>(_createTopping);

    on<UpdateToppingEvent>(_updateTopping);
  }

  Future _createTopping(CreateToppingEvent event, Emitter emit) async {
    emit(AddToppingLoadingState());
    final response = await _createToppingUseCase.call(
        params: ToppingRequest(topping: event.topping, image: image));
    if (response is DataSuccess) {
      emit(AddToppingSuccessState());
    } else {
      emit(AddToppingErrorState(response.error ?? ""));
    }
  }

  Future _updateTopping(UpdateToppingEvent event, Emitter emit) async {
    emit(AddToppingLoadingState());
    final response = await _updateToppingUseCase.call(
        params: ToppingRequest(topping: event.topping, image: image));
    if (response is DataSuccess) {
      emit(AddToppingSuccessState());
    } else {
      emit(AddToppingErrorState(response.error ?? ""));
    }
  }
}
