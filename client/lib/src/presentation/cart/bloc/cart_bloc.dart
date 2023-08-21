import 'package:coffee/injection.dart';
import 'package:coffee/src/core/request/cart_request/change_method_request.dart';
import 'package:coffee/src/core/utils/enum/enums.dart';
import 'package:coffee/src/data/models/order.dart';
import 'package:coffee/src/presentation/cart/bloc/cart_event.dart';
import 'package:coffee/src/presentation/cart/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart' as inject;

import '../../../core/resources/data_state.dart';
import '../../../domain/use_cases/cart_use_case/add_note.dart';
import '../../../domain/use_cases/cart_use_case/attach_coupon_to_order.dart';
import '../../../domain/use_cases/cart_use_case/change_method.dart';
import '../../../domain/use_cases/cart_use_case/delete_coupon_order.dart';
import '../../../domain/use_cases/cart_use_case/delete_order_spending.dart';
import '../../../domain/use_cases/cart_use_case/delete_product.dart';
import '../../../domain/use_cases/cart_use_case/place_oder.dart';

@inject.injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  final AttachCouponToOrderUseCase _attachCouponToOrderUseCase;
  final ChangeMethodUseCase _changeMethodUseCase;
  final DeleteCouponOrderUseCase _deleteCouponOrderUseCase;
  final DeleteOrderSpendingUseCase _deleteOrderSpendingUseCase;
  final DeleteProductUseCase _deleteProductUseCase;
  final PlaceOrderUseCase _placeOrderUseCase;
  final AddNoteUseCase _addNoteUseCase;

  CartBloc(
    this._deleteProductUseCase,
    this._placeOrderUseCase,
    this._deleteOrderSpendingUseCase,
    this._deleteCouponOrderUseCase,
    this._changeMethodUseCase,
    this._attachCouponToOrderUseCase,
    this._addNoteUseCase,
  ) : super(InitState()) {
    on<GetOrderSpending>(_getOrderSpending);

    on<SetPreferencesModel>((event, emit) {
      // preferencesModel = event.preferencesModel.copyWith();
    });

    on<DeleteOrderEvent>(_deleteOrderSpending);

    on<DeleteProductEvent>(_deleteProduct);

    on<ChangeMethod>(_changeMethod);

    on<AttachCouponToOrder>(_attachCouponToOrder);

    on<DeleteCouponOrder>(_deleteCouponOrder);

    on<PlaceOrder>(_placeOrder);

    on<AddNote>(_addNote);
  }

  Future _addNote(AddNote event, Emitter emit) async {
    final response = await _addNoteUseCase.call(params: event.note);
    if (response is DataFailed) {
      emit(GetOrderErrorState(response.error ?? ""));
    }
  }

  Future _placeOrder(PlaceOrder event, Emitter emit) async {
    emit(GetOrderLoadingState());
    final response = await _placeOrderUseCase.call();
    if (response is DataSuccess) {
      emit(GetOrderSuccessState(null, OrderStatus.placed));
    } else {
      emit(GetOrderErrorState(response.error ?? ""));
    }
  }

  Future _changeMethod(ChangeMethod event, Emitter emit) async {
    emit(GetOrderLoadingState());
    final response = await _changeMethodUseCase.call(
        params: ChangeMethodRequest(
            isBringBack: event.isBringBack,
            address: event.address,
            storeID: event.storeID));
    if (response is DataSuccess) {
      emit(ChangeStoreCartState());
      emit(GetOrderSuccessState(Order.fromOrderResponse(response.data!)));
    } else {
      emit(GetOrderErrorState(response.error ?? ""));
    }
  }

  Future _getOrderSpending(GetOrderSpending event, Emitter emit) async {
    emit(GetOrderLoadingState());
    emit(GetOrderSuccessState(getIt<Order>()));
  }

  Future _deleteOrderSpending(DeleteOrderEvent event, Emitter emit) async {
    emit(GetOrderLoadingState());
    final response = await _deleteOrderSpendingUseCase.call();
    if (response is DataSuccess) {
      emit(GetOrderSuccessState(null, OrderStatus.delete));
    } else {
      emit(GetOrderErrorState(response.error ?? ""));
    }
  }

  Future _deleteProduct(DeleteProductEvent event, Emitter emit) async {
    emit(GetOrderLoadingState());
    final response = await _deleteProductUseCase.call(params: event.index);
    if (response is DataSuccess) {
      if (response.data != null) {
        emit(GetOrderSuccessState(Order.fromOrderResponse(response.data!)));
      } else {
        emit(GetOrderSuccessState(null, OrderStatus.delete));
      }
    } else {
      emit(GetOrderErrorState(response.error ?? ""));
    }
  }

  Future _attachCouponToOrder(AttachCouponToOrder event, Emitter emit) async {
    emit(GetOrderLoadingState());
    final response = await _attachCouponToOrderUseCase.call(params: event.id);
    if (response is DataSuccess) {
      emit(GetOrderSuccessState(Order.fromOrderResponse(response.data!)));
    } else {
      emit(GetOrderErrorState(response.error ?? ""));
    }
  }

  Future _deleteCouponOrder(DeleteCouponOrder event, Emitter emit) async {
    emit(GetOrderLoadingState());
    final response = await _deleteCouponOrderUseCase.call();
    if (response is DataSuccess) {
      emit(GetOrderSuccessState(Order.fromOrderResponse(response.data!)));
    } else {
      emit(GetOrderErrorState(response.error ?? ""));
    }
  }
}
