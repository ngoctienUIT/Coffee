import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/server_status.dart';
import '../../../data/models/topping.dart';
import '../../../domain/api_service.dart';
import 'add_topping_event.dart';
import 'add_topping_state.dart';

class AddToppingBloc extends Bloc<AddToppingEvent, AddToppingState> {
  String image = "";

  AddToppingBloc() : super(InitState()) {
    on<SaveButtonEvent>(
        (event, emit) => emit(SaveButtonState(event.isContinue)));

    on<ChangeImageEvent>((event, emit) {
      image = event.image;
      emit(ChangeImageState());
    });

    on<CreateToppingEvent>((event, emit) => createTopping(event.topping, emit));

    on<UpdateToppingEvent>((event, emit) => updateTopping(event.topping, emit));
  }

  Future createTopping(Topping topping, Emitter emit) async {
    try {
      emit(AddToppingLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      if (image.isNotEmpty) {
        topping.imageUrl = await uploadImage(image.split("/").last);
      }
      await apiService.createNewTopping(
        'Bearer $token',
        topping.toJson(),
      );
      emit(AddToppingSuccessState());
    } catch (e) {
      emit(AddToppingErrorState(serverStatus(e)!));
      print(e);
    }
  }

  Future updateTopping(Topping topping, Emitter emit) async {
    try {
      emit(AddToppingLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      if (image.isNotEmpty) {
        topping.imageUrl = await uploadImage(image.split("/").last);
      }
      await apiService.updateExistingTopping(
        topping.toppingId!,
        'Bearer $token',
        topping.toJson(),
      );
      emit(AddToppingSuccessState());
    } catch (e) {
      emit(AddToppingErrorState(serverStatus(e)!));
      print(e);
    }
  }

  Future<String> uploadImage(String name) async {
    Reference upload = FirebaseStorage.instance.ref().child("topping/$name");
    await upload.putFile(File(image));
    return await upload.getDownloadURL();
  }
}
