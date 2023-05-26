import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/preferences_model.dart';
import '../../../data/models/topping.dart';
import '../../../domain/api_service.dart';
import 'add_topping_event.dart';
import 'add_topping_state.dart';

class AddToppingBloc extends Bloc<AddToppingEvent, AddToppingState> {
  String image = "";
  PreferencesModel preferencesModel;

  AddToppingBloc(this.preferencesModel) : super(InitState()) {
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
      if (image.isNotEmpty) {
        topping.imageUrl = await uploadImage(image.split("/").last);
      }
      await apiService.createNewTopping(
          'Bearer ${preferencesModel.token}', topping.toJson());
      emit(AddToppingSuccessState());
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(AddToppingErrorState(error));
      print(error);
    } catch (e) {
      emit(AddToppingErrorState(e.toString()));
      print(e);
    }
  }

  Future updateTopping(Topping topping, Emitter emit) async {
    try {
      emit(AddToppingLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      if (image.isNotEmpty) {
        topping.imageUrl = await uploadImage(image.split("/").last);
      }
      await apiService.updateExistingTopping(topping.toppingId!,
          'Bearer ${preferencesModel.token}', topping.toJson());
      emit(AddToppingSuccessState());
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(AddToppingErrorState(error));
      print(error);
    } catch (e) {
      emit(AddToppingErrorState(e.toString()));
      print(e);
    }
  }

  Future<String> uploadImage(String name) async {
    Reference upload = FirebaseStorage.instance.ref().child("topping/$name");
    await upload.putFile(File(image));
    return await upload.getDownloadURL();
  }
}
