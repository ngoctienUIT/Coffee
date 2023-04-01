import 'package:flutter_bloc/flutter_bloc.dart';

import 'view_product_event.dart';
import 'view_product_state.dart';

class ViewProductBloc extends Bloc<ViewProductEvent, ViewProductState> {
  ViewProductBloc() : super(InitState()) {
    on<DataTransmissionEvent>(
        (event, emit) => emit(DataTransmissionState(event.product)));
  }
}
