import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/presentation/product_catalogues/bloc/product_catalogues_event.dart';
import 'package:coffee_admin/src/presentation/product_catalogues/bloc/product_catalogues_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/product_catalogues_use_case/delete_product_catalogues.dart';
import '../../../domain/use_cases/product_catalogues_use_case/get_product_catalogues.dart';

@injectable
class ProductCataloguesBloc
    extends Bloc<ProductCataloguesEvent, ProductCataloguesState> {
  final GetProductCataloguesUseCase _getProductCataloguesUseCase;
  final DeleteProductCataloguesUseCase _deleteProductCataloguesUseCase;

  ProductCataloguesBloc(
    this._getProductCataloguesUseCase,
    this._deleteProductCataloguesUseCase,
  ) : super(InitState()) {
    on<FetchData>((event, emit) => getData(true, emit));

    on<UpdateData>((event, emit) => getData(false, emit));

    on<DeleteEvent>(_deleteProductCatalogues);
  }

  Future getData(bool check, Emitter emit) async {
    if (check) emit(ProductCataloguesLoading());
    final response = await _getProductCataloguesUseCase.call();
    if (response is DataSuccess) {
      emit(ProductCataloguesLoaded(response.data!));
    } else {
      emit(ProductCataloguesError(response.error));
    }
  }

  Future _deleteProductCatalogues(DeleteEvent event, Emitter emit) async {
    emit(ProductCataloguesLoading(false));
    final response =
        await _deleteProductCataloguesUseCase.call(params: event.id);
    if (response is DataSuccess) {
      emit(DeleteSuccess(event.id));
    } else {
      emit(ProductCataloguesError(response.error));
    }
  }
}
