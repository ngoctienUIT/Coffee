import 'package:coffee/src/presentation/other/bloc/other_event.dart';
import 'package:coffee/src/presentation/other/bloc/other_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtherBloc extends Bloc<OtherEvent, OtherState> {
  OtherBloc() : super(InitState()) {
    on<ChangeLanguageEvent>(
        (event, emit) => emit(ChangeLanguageState(language: event.language)));
  }
}
