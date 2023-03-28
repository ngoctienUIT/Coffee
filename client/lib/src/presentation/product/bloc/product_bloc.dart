import 'package:coffee/src/presentation/product/bloc/product_event.dart';
import 'package:coffee/src/presentation/product/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(InitState()) {
    on<DataTransmissionEvent>(
        (event, emit) => emit(DataTransmissionState(event.product)));
  }
}
