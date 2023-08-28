import 'package:coffee_admin/src/core/request/product_request/product_request.dart';
import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/presentation/add_product/bloc/add_product_event.dart';
import 'package:coffee_admin/src/presentation/add_product/bloc/add_product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/product_use_case/create_product.dart';
import '../../../domain/use_cases/product_use_case/update_product.dart';

@injectable
class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  String image = "";
  String catalogueID = "";
  final CreateProductUseCase _createProductUseCase;
  final UpdateProductUseCase _updateProductUseCase;

  AddProductBloc(this._createProductUseCase, this._updateProductUseCase)
      : super(InitState()) {
    on<ChangeImageEvent>((event, emit) {
      image = event.image;
      emit(ChangeImageState());
    });

    on<ChangeCatalogueEvent>((event, emit) {
      catalogueID = event.id;
      emit(ChangeCatalogueState());
    });

    on<ChangeToppingEvent>((event, emit) => emit(ChangeToppingState()));

    on<ChangeTagEvent>((event, emit) => emit(ChangeTagState()));

    on<SaveButtonEvent>(
        (event, emit) => emit(SaveButtonState(event.isContinue)));

    on<CreateProductEvent>(_createProduct);

    on<UpdateProductEvent>(_updateProduct);
  }

  Future _createProduct(CreateProductEvent event, Emitter emit) async {
    emit(AddProductLoadingState());
    final response = await _createProductUseCase.call(
        params: ProductRequest(
            product: event.product, image: image, catalogueID: catalogueID));
    if (response is DataSuccess) {
      emit(AddProductSuccessState());
    } else {
      emit(AddProductErrorState(response.error ?? ""));
    }
  }

  Future _updateProduct(UpdateProductEvent event, Emitter emit) async {
    emit(AddProductLoadingState());
    final response = await _updateProductUseCase.call(
        params: ProductRequest(product: event.product, image: image));
    if (response is DataSuccess) {
      emit(AddProductSuccessState());
    } else {
      emit(AddProductErrorState(response.error ?? ""));
    }
  }
}
