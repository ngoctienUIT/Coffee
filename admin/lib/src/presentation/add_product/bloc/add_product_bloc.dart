import 'package:coffee_admin/src/data/models/product.dart';
import 'package:coffee_admin/src/presentation/add_product/bloc/add_product_event.dart';
import 'package:coffee_admin/src/presentation/add_product/bloc/add_product_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  AddProductBloc() : super(InitState()) {
    on<ChangeImageEvent>((event, emit) => emit(ChangeImageState()));

    on<SaveButtonEvent>(
        (event, emit) => emit(SaveButtonState(event.isContinue)));

    on<CreateProductEvent>((event, emit) => createProduct(event.product, emit));

    on<UpdateProductEvent>((event, emit) => updateProduct(event.product, emit));
  }

  Future createProduct(Product product, Emitter emit) async {
    try {
      emit(AddProductLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      final response = await apiService.createNewProduct(
        'Bearer $token',
        product.toJson(),
      );
      emit(AddProductSuccessState());
    } catch (e) {
      emit(AddProductErrorState(e.toString()));
      print(e);
    }
  }

  Future updateProduct(Product product, Emitter emit) async {
    try {
      emit(AddProductLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      final response = await apiService.updateExistingProducts(
        product.id!,
        'Bearer $token',
        product.toJson(),
      );
      emit(AddProductSuccessState());
    } catch (e) {
      emit(AddProductErrorState(e.toString()));
      print(e);
    }
  }
}
