import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/preferences_model.dart';
import '../../../data/models/product_catalogues.dart';
import '../../../domain/api_service.dart';
import 'add_product_catalogues_event.dart';
import 'add_product_catalogues_state.dart';

class AddProductCataloguesBloc
    extends Bloc<AddProductCataloguesEvent, AddProductCataloguesState> {
  String image = "";
  PreferencesModel preferencesModel;

  AddProductCataloguesBloc(this.preferencesModel) : super(InitState()) {
    on<SaveButtonEvent>(
        (event, emit) => emit(SaveButtonState(event.isContinue)));

    on<ChangeImageEvent>((event, emit) {
      image = event.image;
      emit(ChangeImageState());
    });

    on<CreateProductCataloguesEvent>((event, emit) =>
        createProductCatalogues(event.productCatalogues, emit));

    on<UpdateProductCataloguesEvent>((event, emit) =>
        updateProductCatalogues(event.productCatalogues, emit));
  }

  Future createProductCatalogues(
      ProductCatalogues productCatalogues, Emitter emit) async {
    try {
      emit(AddProductCataloguesLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));

      if (image.isNotEmpty) {
        productCatalogues.image = await uploadImage(image.split("/").last);
      }
      await apiService.createNewProductCatalogue(
        'Bearer ${preferencesModel.token}',
        productCatalogues.toJson(),
      );
      emit(AddProductCataloguesSuccessState());
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(AddProductCataloguesErrorState(error));
      print(error);
    } catch (e) {
      emit(AddProductCataloguesErrorState(e.toString()));
      print(e);
    }
  }

  Future updateProductCatalogues(
      ProductCatalogues productCatalogues, Emitter emit) async {
    try {
      emit(AddProductCataloguesLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      if (image.isNotEmpty) {
        productCatalogues.image = await uploadImage(image.split("/").last);
      }
      await apiService.updateExistingProductCatalogue(
        'Bearer ${preferencesModel.token}',
        productCatalogues.toJson(),
        productCatalogues.id!,
      );
      emit(AddProductCataloguesSuccessState());
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(AddProductCataloguesErrorState(error));
      print(error);
    } catch (e) {
      emit(AddProductCataloguesErrorState(e.toString()));
      print(e);
    }
  }

  Future<String> uploadImage(String name) async {
    Reference upload =
        FirebaseStorage.instance.ref().child("ProductCatalogues/$name");
    await upload.putFile(File(image));
    return await upload.getDownloadURL();
  }
}
