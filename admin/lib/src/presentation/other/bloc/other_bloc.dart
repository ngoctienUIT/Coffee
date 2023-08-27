import 'package:flutter_bloc/flutter_bloc.dart';

import 'other_event.dart';
import 'other_state.dart';

class OtherBloc extends Bloc<OtherEvent, OtherState> {
  OtherBloc() : super(InitState()) {
    // on<FetchData>((event, emit) => getUserInfo(emit));

    on<ChangeLanguageEvent>(
        (event, emit) => emit(ChangeLanguageState(language: event.language)));
  }
}
