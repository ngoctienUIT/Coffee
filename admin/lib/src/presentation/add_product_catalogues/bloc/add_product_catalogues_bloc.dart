import 'package:coffee_admin/src/core/request/product_catalogues_request/product_catalogues_request.dart';
import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/product_catalogues_use_case/create_product_catalogues.dart';
import '../../../domain/use_cases/product_catalogues_use_case/update_product_catalogues.dart';
import 'add_product_catalogues_event.dart';
import 'add_product_catalogues_state.dart';

@injectable
class AddProductCataloguesBloc
    extends Bloc<AddProductCataloguesEvent, AddProductCataloguesState> {
  String image = "";
  final CreateProductCataloguesUseCase _createProductCataloguesUseCase;
  final UpdateProductCataloguesUseCase _updateProductCataloguesUseCase;

  AddProductCataloguesBloc(
    this._createProductCataloguesUseCase,
    this._updateProductCataloguesUseCase,
  ) : super(InitState()) {
    on<SaveButtonEvent>(
        (event, emit) => emit(SaveButtonState(event.isContinue)));

    on<ChangeImageEvent>((event, emit) {
      image = event.image;
      emit(ChangeImageState());
    });

    on<CreateProductCataloguesEvent>(_createProductCatalogues);

    on<UpdateProductCataloguesEvent>(_updateProductCatalogues);
  }

  Future _createProductCatalogues(
      CreateProductCataloguesEvent event, Emitter emit) async {
    emit(AddProductCataloguesLoadingState());
    final response = await _createProductCataloguesUseCase.call(
        params: ProductCataloguesRequest(
      image: image,
      productCatalogues: event.productCatalogues,
    ));
    if (response is DataSuccess) {
      emit(AddProductCataloguesSuccessState());
    } else {
      emit(AddProductCataloguesErrorState(response.error ?? ""));
    }
  }

  Future _updateProductCatalogues(
      UpdateProductCataloguesEvent event, Emitter emit) async {
    emit(AddProductCataloguesLoadingState());
    final response = await _updateProductCataloguesUseCase.call(
        params: ProductCataloguesRequest(
      image: image,
      productCatalogues: event.productCatalogues,
    ));
    if (response is DataSuccess) {
      emit(AddProductCataloguesSuccessState());
    } else {
      emit(AddProductCataloguesErrorState(response.error ?? ""));
    }
  }
}
