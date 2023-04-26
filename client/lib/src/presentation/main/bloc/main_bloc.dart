import 'package:coffee/src/presentation/main/bloc/main_event.dart';
import 'package:coffee/src/presentation/main/bloc/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(InitState()) {
    on<ChangeCartHomeEvent>((event, emit) => emit(ChangeCartHomeState()));

    on<ChangeCartOrderEvent>((event, emit) => emit(ChangeCartOrderState()));

    on<UpdateActivityEvent>((event, emit) => emit(UpdateActivityState()));
  }
}
