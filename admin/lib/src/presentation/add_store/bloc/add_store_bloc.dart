import 'package:coffee_admin/src/presentation/add_store/bloc/add_store_event.dart';
import 'package:coffee_admin/src/presentation/add_store/bloc/add_store_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddStoreBloc extends Bloc<AddStoreEvent, AddStoreState> {
  AddStoreBloc() : super(InitState()) {
    on((event, emit) => null);
  }
}
