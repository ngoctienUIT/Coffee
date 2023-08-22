import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/core/utils/extensions/dio_extension.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../core/request/input_info_request/input_info_request.dart';
import '../../domain/repositories/input_info_repository.dart';
import '../remote/api_service/api_service.dart';

@LazySingleton(as: InputInfoRepository)
class InputInfoRepositoryImpl extends InputInfoRepository {
  InputInfoRepositoryImpl(this._apiService);

  final ApiService _apiService;

  @override
  Future<DataState<dynamic>> submitInfo(InputInfoRequest request) async {
    try {
      await _apiService.signup(request.user.toJson());
      final response = await _apiService
          .login({"loginIdentity": request.user.email, "hashedPassword": ""});
      final GoogleSignInAuthentication googleAuth =
          await request.account.authentication;
      _apiService.linkAccountWithOAuth2Provider(
          "Bearer ${response.data.accessToken}", {
        "oauth2ProviderUserId": request.account.id,
        "oauth2ProviderUserIdentity": request.user.email,
        "oauth2ProviderAccessToken": googleAuth.accessToken,
        "oauth2ProviderProviderName": "GOOGLE"
      });
      return DataSuccess("ok");
    } on DioException catch (e) {
      String error = e.getError();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }
}
