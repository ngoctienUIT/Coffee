import 'dart:io';

import 'package:coffee_admin/src/data/models/product.dart';
import 'package:coffee_admin/src/presentation/add_product/bloc/add_product_event.dart';
import 'package:coffee_admin/src/presentation/add_product/bloc/add_product_state.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/preferences_model.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  String image = "";
  String catalogueID = "";
  PreferencesModel preferencesModel;

  AddProductBloc(this.preferencesModel) : super(InitState()) {
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

    on<CreateProductEvent>((event, emit) => createProduct(event.product, emit));

    on<UpdateProductEvent>((event, emit) => updateProduct(event.product, emit));
  }

  Future createProduct(Product product, Emitter emit) async {
    try {
      emit(AddProductLoadingState());
      if (image.isNotEmpty) {
        product.image = await uploadImage(image.split("/").last);
      }
      final catalogueResponse = await preferencesModel.apiService
          .getProductCatalogueByID(catalogueID);
      final response = await preferencesModel.apiService.createNewProduct(
          'Bearer ${preferencesModel.token}', product.toJson());
      List<String> list = catalogueResponse.data.associatedProductIds!;
      list.add(response.data.id);
      await preferencesModel.apiService.updateProductIdsProductCatalogues(
          'Bearer ${preferencesModel.token}', list, catalogueID);
      emit(AddProductSuccessState());
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(AddProductErrorState(error));
      print(error);
    } catch (e) {
      emit(AddProductErrorState(e.toString()));
      print(e);
    }
  }

  Future updateProduct(Product product, Emitter emit) async {
    try {
      emit(AddProductLoadingState());
      if (image.isNotEmpty) {
        product.image = await uploadImage(image.split("/").last);
      }
      await preferencesModel.apiService.updateExistingProducts(
          product.id!, 'Bearer ${preferencesModel.token}', product.toJson());
      emit(AddProductSuccessState());
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(AddProductErrorState(error));
      print(error);
    } catch (e) {
      emit(AddProductErrorState(e.toString()));
      print(e);
    }
  }

  Future<String> uploadImage(String name) async {
    Reference upload = FirebaseStorage.instance.ref().child("product/$name");
    await upload.putFile(File(image));
    return await upload.getDownloadURL();
  }
}
