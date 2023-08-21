import 'package:coffee/injection.dart';
import 'package:coffee/src/core/request/product_request/delete_product_in_order_request.dart';
import 'package:coffee/src/core/request/product_request/update_order_request.dart';
import 'package:coffee/src/core/request/product_request/update_product_in_order_request.dart';
import 'package:coffee/src/core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart' as inject;

import '../../../data/models/order.dart';
import '../../../data/models/product.dart';
import '../../../domain/use_cases/product_use_case/create_new_order.dart';
import '../../../domain/use_cases/product_use_case/delete_product_in_order.dart';
import '../../../domain/use_cases/product_use_case/update_pending_order.dart';
import '../../../domain/use_cases/product_use_case/update_product_in_order.dart';
import 'product_event.dart';
import 'product_state.dart';

@inject.injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  Product product = Product(name: "", currency: "", price: 0, M: 0, L: 0);
  final CreateNewOrderUseCase _createNewOrderUseCase;
  final DeleteProductInOrderUseCase _deleteProductInOrderUseCase;
  final UpdatePendingOrderUseCase _updatePendingOrderUseCase;
  final UpdateProductInOrderUseCase _updateProductInOrderUseCase;

  ProductBloc(
    this._updatePendingOrderUseCase,
    this._updateProductInOrderUseCase,
    this._deleteProductInOrderUseCase,
    this._createNewOrderUseCase,
  ) : super(InitState()) {
    on<DataTransmissionEvent>((event, emit) {
      product = event.product.copyWith();
      emit(DataTransmissionState());
    });

    on<AddProductToOrderEvent>(_addProductToOrder);

    on<UpdateProductEvent>(_updateProductOrder);

    on<DeleteProductEvent>(_deleteProductOrder);
  }

  Future _addProductToOrder(AddProductToOrderEvent event, Emitter emit) async {
    emit(ProductLoadingState());
    if (!getIt.isRegistered(instance: Order)) {
      final response = await _createNewOrderUseCase.call(params: event.product);
      if (response is DataSuccess) {
        emit(AddProductToOrderSuccessState(response.data!));
      } else {
        emit(ProductErrorState(response.error ?? ""));
      }
    } else {
      final response = await _updatePendingOrderUseCase.call(
          params: UpdateOrderRequest(
              order: getIt<Order>(), product: event.product));
      if (response is DataSuccess) {
        emit(AddProductToOrderSuccessState(response.data!));
      } else {
        emit(ProductErrorState(response.error ?? ""));
      }
    }
  }

  Future _updateProductOrder(UpdateProductEvent event, Emitter emit) async {
    emit(ProductLoadingState());
    final response = await _updateProductInOrderUseCase.call(
        params: UpdateProductInOrderRequest(
            index: event.index, product: event.product, order: getIt<Order>()));
    if (response is DataSuccess) {
      emit(UpdateSuccessState(response.data!));
    } else {
      emit(ProductErrorState(response.error ?? ""));
    }
  }

  Future _deleteProductOrder(DeleteProductEvent event, Emitter emit) async {
    emit(ProductLoadingState());
    final response = await _deleteProductInOrderUseCase.call(
        params: DeleteProductInOrderRequest(event.index, getIt<Order>()));
    if (response is DataSuccess) {
      emit(DeleteSuccessState(response.data!));
    } else {
      emit(ProductErrorState(response.error ?? ""));
    }
  }
}
