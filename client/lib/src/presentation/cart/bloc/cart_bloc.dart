import 'package:coffee/src/presentation/cart/bloc/cart_event.dart';
import 'package:coffee/src/presentation/cart/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(InitState());
}
