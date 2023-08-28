import 'package:coffee/src/presentation/order/bloc/order_event.dart';
import 'package:coffee/src/presentation/order/bloc/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/product_catalogues/product_catalogues_response.dart';
import '../../../domain/use_cases/order_use_case/get_list_product.dart';
import '../../../domain/use_cases/order_use_case/get_list_product_catalogues.dart';

@injectable
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  List<ProductCataloguesResponse> listProductCatalogues = [];
  final GetListProductUseCase _getListProductUseCase;
  final GetListProductCatalogues _getListProductCatalogues;

  OrderBloc(this._getListProductUseCase, this._getListProductCatalogues)
      : super(InitState()) {
    on<FetchData>(_fetchData);

    on<RefreshData>(_refreshData);
  }

  Future _fetchData(FetchData event, Emitter emit) async {
    emit(OrderLoading());
    final response = await _getListProductCatalogues.call();
    if (response is DataSuccess) {
      listProductCatalogues = response.data!;
      final listProduct = await _getListProductUseCase.call(
          params: listProductCatalogues[0].id);
      if (listProduct is DataSuccess) {
        emit(OrderLoaded(
          index: 0,
          listProduct: listProduct.data!,
          listProductCatalogues: listProductCatalogues,
        ));
      } else {
        emit(OrderError(response.error));
      }
    } else {
      emit(OrderError(response.error));
    }
  }

  Future _refreshData(RefreshData event, Emitter emit) async {
    emit(RefreshOrderLoading(event.index));
    final response = await _getListProductUseCase.call(
        params: listProductCatalogues[event.index].id);
    if (response is DataSuccess) {
      emit(RefreshOrderLoaded(event.index, response.data!));
    } else {
      emit(OrderError(response.error));
    }
  }
}
