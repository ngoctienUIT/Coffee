import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/preferences_model.dart';
import '../../../data/models/store.dart';
import '../../../domain/api_service.dart';
import 'add_store_event.dart';
import 'add_store_state.dart';

class AddStoreBloc extends Bloc<AddStoreEvent, AddStoreState> {
  String image = "";
  PreferencesModel preferencesModel;

  AddStoreBloc(this.preferencesModel) : super(InitState()) {
    on<ChangeImageEvent>((event, emit) {
      image = event.image;
      emit(ChangeImageState());
    });

    on<ChangeAddressEvent>((event, emit) => emit(ChangeAddressState()));

    on<ChangeCloseEvent>((event, emit) => emit(ChangeCloseState()));

    on<ChangeOpenEvent>((event, emit) => emit(ChangeOpenState()));

    on<SaveButtonEvent>(
        (event, emit) => emit(SaveButtonState(event.isContinue)));

    on<CreateStoreEvent>((event, emit) => createStore(event.store, emit));

    on<UpdateStoreEvent>((event, emit) => updateStore(event.store, emit));
  }

  Future createStore(Store store, Emitter emit) async {
    try {
      emit(AddStoreLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      if (image.isNotEmpty) {
        store.imageUrl = await uploadImage(image.split("/").last);
      }
      await apiService.registerNewStore(
          'Bearer ${preferencesModel.token}', store.toJson());
      emit(AddStoreSuccessState());
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(AddStoreErrorState(error));
      print(error);
    } catch (e) {
      emit(AddStoreErrorState(e.toString()));
      print(e);
    }
  }

  Future updateStore(Store store, Emitter emit) async {
    try {
      emit(AddStoreLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      if (image.isNotEmpty) {
        store.imageUrl = await uploadImage(image.split("/").last);
      }
      await apiService.updateExistingStore(
          store.storeId!, 'Bearer ${preferencesModel.token}', store.toJson());
      emit(AddStoreSuccessState());
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(AddStoreErrorState(error));
      print(error);
    } catch (e) {
      emit(AddStoreErrorState(e.toString()));
      print(e);
    }
  }

  Future<String> uploadImage(String name) async {
    Reference upload = FirebaseStorage.instance.ref().child("Store/$name");
    await upload.putFile(File(image));
    return await upload.getDownloadURL();
  }
}
