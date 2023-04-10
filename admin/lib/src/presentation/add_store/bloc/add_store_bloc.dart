import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/server_status.dart';
import '../../../data/models/store.dart';
import '../../../domain/api_service.dart';
import 'add_store_event.dart';
import 'add_store_state.dart';

class AddStoreBloc extends Bloc<AddStoreEvent, AddStoreState> {
  String image = "";

  AddStoreBloc() : super(InitState()) {
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
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      if (image.isNotEmpty) {
        store.imageUrl = await uploadImage(image.split("/").last);
      }
      await apiService.registerNewStore('Bearer $token', store.toJson());
      emit(AddStoreSuccessState());
    } catch (e) {
      if (serverStatus(e) != null) {
        emit(AddStoreErrorState(serverStatus(e)!));
      }
      print(e);
    }
  }

  Future updateStore(Store store, Emitter emit) async {
    try {
      emit(AddStoreLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      if (image.isNotEmpty) {
        store.imageUrl = await uploadImage(image.split("/").last);
      }
      await apiService.updateExistingStore(
          store.storeId!, 'Bearer $token', store.toJson());
      emit(AddStoreSuccessState());
    } catch (e) {
      emit(AddStoreErrorState(serverStatus(e)!));
      print(e);
    }
  }

  Future<String> uploadImage(String name) async {
    Reference upload = FirebaseStorage.instance.ref().child("Store/$name");
    await upload.putFile(File(image));
    return await upload.getDownloadURL();
  }
}
