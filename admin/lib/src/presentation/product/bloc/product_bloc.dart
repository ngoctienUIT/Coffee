import 'package:coffee_admin/src/core/request/product_request/delete_product_request.dart';
import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/presentation/product/bloc/product_event.dart';
import 'package:coffee_admin/src/presentation/product/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/remote/response/product_catalogues/product_catalogues_response.dart';
import '../../../domain/use_cases/product_catalogues_use_case/get_product_catalogues.dart';
import '../../../domain/use_cases/product_use_case/delete_product.dart';
import '../../../domain/use_cases/product_use_case/get_product.dart';

@injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  List<ProductCataloguesResponse> listProductCatalogues = [];
  final DeleteProductUseCase _deleteProductUseCase;
  final GetProductUseCase _getProductUseCase;
  final GetProductCataloguesUseCase _getProductCataloguesUseCase;

  ProductBloc(
    this._deleteProductUseCase,
    this._getProductUseCase,
    this._getProductCataloguesUseCase,
  ) : super(InitState()) {
    on<FetchData>((event, emit) => getData(emit));

    on<RefreshData>((event, emit) => getDataProduct(event.index, emit));

    on<UpdateData>((event, emit) => updateDataProduct(event.index, emit));

    on<DeleteEvent>(
        (event, emit) => deleteProduct(event.id, event.index, emit));
  }

  Future getData(Emitter emit) async {
    emit(ProductLoading());
    final cataloguesResponse = await _getProductCataloguesUseCase.call();
    if (cataloguesResponse is DataSuccess) {
      listProductCatalogues = cataloguesResponse.data!;
      final response =
          await _getProductUseCase.call(params: cataloguesResponse.data![0].id);
      if (response is DataSuccess) {
        emit(ProductLoaded(0, response.data!, listProductCatalogues));
      } else {
        emit(ProductError(response.error ?? ""));
      }
    } else {
      emit(ProductError(cataloguesResponse.error ?? ""));
    }
  }

  Future getDataProduct(int index, Emitter emit) async {
    emit(RefreshLoading());
    final productResponse =
        await _getProductUseCase.call(params: listProductCatalogues[index].id);
    if (productResponse is DataSuccess) {
      final response = await _getProductCataloguesUseCase.call();
      if (response is DataSuccess) {
        if (response.data!.length != listProductCatalogues.length) {
          listProductCatalogues = response.data!;
        }
        emit(
            ProductLoaded(index, productResponse.data!, listProductCatalogues));
      } else {
        emit(ProductError(response.error ?? ""));
      }
    } else {
      emit(ProductError(productResponse.error ?? ""));
    }
  }

  Future updateDataProduct(int index, Emitter emit) async {
    final response =
        await _getProductUseCase.call(params: listProductCatalogues[index].id);
    if (response is DataSuccess) {
      emit(RefreshLoaded(index, response.data!));
    } else {
      emit(ProductError(response.error));
    }
  }

  Future deleteProduct(String id, int index, Emitter emit) async {
    emit(ProductLoading(false));
    final response = await _deleteProductUseCase.call(
        params: DeleteProductRequest(id, listProductCatalogues[index].id));
    if (response is DataSuccess) {
      final responseProduct = await _getProductUseCase.call(
          params: listProductCatalogues[index].id);
      if (response is DataSuccess) {
        emit(RefreshLoaded(index, responseProduct.data!, false));
      } else {
        emit(ProductError(responseProduct.error));
      }
    } else {
      emit(ProductError(response.error));
    }
  }
}
