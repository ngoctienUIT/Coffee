import 'package:coffee/src/data/models/user.dart';
import 'package:coffee/src/domain/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'input_info_event.dart';
import 'input_info_state.dart';

class InputInfoBloc extends Bloc<InputInfoEvent, InputInfoState> {
  InputInfoBloc() : super(InitState()) {
    on<SubmitEvent>(
        (event, emit) => submitInfo(event.account, event.user, emit));

    on<ClickSubmitEvent>(
        (event, emit) => emit(ContinueState(isContinue: event.isContinue)));

    on<ChangeBirthdayEvent>((event, emit) => emit(ChangeBirthdayState()));

    on<ChangeGenderEvent>((event, emit) => emit(ChangeGenderState()));
  }

  Future submitInfo(
      GoogleSignInAccount account, User user, Emitter emit) async {
    try {
      emit(SubmitLoadingState());
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      await apiService.signup(user.toJson());
      final response = await apiService
          .login({"loginIdentity": user.email, "hashedPassword": ""});
      final GoogleSignInAuthentication googleAuth =
          await account.authentication;
      apiService.linkAccountWithOAuth2Provider(
          "Bearer ${response.data.accessToken}", {
        "oauth2ProviderUserId": account.id,
        "oauth2ProviderUserIdentity": user.email,
        "oauth2ProviderAccessToken": googleAuth.accessToken,
        "oauth2ProviderProviderName": "GOOGLE"
      });
      GoogleSignIn().signOut();
      emit(SubmitSuccessState());
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      Fluttertoast.showToast(msg: error);
      GoogleSignIn().signOut();
      emit(SubmitErrorState(status: error));
      print(error);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      GoogleSignIn().signOut();
      emit(SubmitErrorState(status: e.toString()));
      print(e);
    }
  }
}