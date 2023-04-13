import 'package:coffee/src/core/utils/constants/app_images.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/input_pin/screen/input_pin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/enum/enums.dart';
import '../../../domain/api_service.dart';
import '../../coupon/widgets/app_bar_general.dart';
import '../../login/widgets/custom_button.dart';
import '../../signup/widgets/custom_text_input.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarGeneral(elevation: 0),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(AppImages.imgLogo, height: 200),
                ),
                Text("forgot_your_password".translate(context)),
                const SizedBox(height: 20),
                CustomTextInput(
                  controller: controller,
                  hint: "Email",
                  typeInput: const [TypeInput.email],
                ),
                const SizedBox(height: 20),
                Text("enter_email_phone_reset_password".translate(context)),
                const SizedBox(height: 50),
                customButton(
                  text: "continue".translate(context),
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      sendApi().then((value) {
                        Navigator.of(context).push(createRoute(
                          screen: InputPin(resetCredential: value!),
                          begin: const Offset(1, 0),
                        ));
                      });
                    }
                  },
                  isOnPress: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> sendApi() async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      return (await apiService.resetPasswordIssue(controller.text)).data;
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      Fluttertoast.showToast(msg: error);
      print(error);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      print(e);
    }
    return null;
  }
}
