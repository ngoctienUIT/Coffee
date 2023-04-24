import 'package:coffee_admin/src/presentation/add_recommend/bloc/add_recommend_event.dart';
import 'package:coffee_admin/src/presentation/add_recommend/bloc/add_recommend_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddRecommendBloc extends Bloc<AddRecommendEvent, AddRecommendState> {
  AddRecommendBloc() : super(InitState()) {
    on<SaveButtonEvent>(
        (event, emit) => emit(SaveButtonState(event.isContinue)));

    on<ChangeTagEvent>((event, emit) => emit(ChangeTagState()));

    on<ChangeWeatherEvent>((event, emit) => emit(ChangeWeatherState()));
  }
}
