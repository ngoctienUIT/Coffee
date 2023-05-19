import 'package:coffee/src/core/services/bloc/service_event.dart';
import 'package:coffee/src/core/services/bloc/service_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/preferences_model.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  PreferencesModel preferencesModel = PreferencesModel();

  ServiceBloc() : super(InitState()) {
    on<SetDataEvent>(
        (event, emit) => preferencesModel = event.preferencesModel.copyWith());
  }
}
