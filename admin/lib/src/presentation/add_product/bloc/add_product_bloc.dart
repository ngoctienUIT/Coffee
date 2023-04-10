import 'dart:io';

import 'package:coffee_admin/src/data/models/product.dart';
import 'package:coffee_admin/src/presentation/add_product/bloc/add_product_event.dart';
import 'package:coffee_admin/src/presentation/add_product/bloc/add_product_state.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/server_status.dart';
import '../../../domain/api_service.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  String image = "";
  String catalogueID = "";

  AddProductBloc() : super(InitState()) {
    on<ChangeImageEvent>((event, emit) {
      image = event.image;
      emit(ChangeImageState());
    });

    on<ChangeCatalogueEvent>((event, emit) {
      catalogueID = event.id;
      emit(ChangeCatalogueState());
    });

    on<ChangeToppingEvent>((event, emit) => emit(ChangeToppingState()));

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
      if (image.isNotEmpty) {
        product.image = await uploadImage(image.split("/").last);
      }
      final catalogueResponse =
          await apiService.getProductCatalogueByID(catalogueID);
      final response =
          await apiService.createNewProduct('Bearer $token', product.toJson());
      List<String> list = catalogueResponse.data.associatedProductIds!;
      list.add(response.data.id);
      await apiService.updateProductIdsProductCatalogues(
          'Bearer $token', list, catalogueID);
      emit(AddProductSuccessState());
    } catch (e) {
      if (serverStatus(e) != null) {
        emit(AddProductErrorState(serverStatus(e)!));
      }
      print(e);
    }
  }

  Future updateProduct(Product product, Emitter emit) async {
    // try {
    emit(AddProductLoadingState());
    ApiService apiService =
        ApiService(Dio(BaseOptions(contentType: "application/json")));
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    if (image.isNotEmpty) {
      product.image = await uploadImage(image.split("/").last);
    }
    await apiService.updateExistingProducts(
        product.id!, 'Bearer $token', product.toJson());
    emit(AddProductSuccessState());
    // } catch (e) {
    //   emit(AddProductErrorState(serverStatus(e)!));
    //   print(e);
    // }
  }

  Future<String> uploadImage(String name) async {
    Reference upload = FirebaseStorage.instance.ref().child("product/$name");
    await upload.putFile(File(image));
    return await upload.getDownloadURL();
  }
}
