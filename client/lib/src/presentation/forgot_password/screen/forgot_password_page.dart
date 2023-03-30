import 'package:coffee/src/core/utils/constants/app_images.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/enum/enums.dart';
import '../../../domain/api_service.dart';
import '../../login/widgets/custom_button.dart';
import '../../signup/widgets/custom_text_input.dart';
import '../../voucher/widgets/app_bar_general.dart';

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
                  child: Image.asset(
                    AppImages.imgLogo,
                    height: 200,
                  ),
                ),
                Text("forgot_your_password".translate(context)),
                const SizedBox(height: 20),
                CustomTextInput(
                  controller: controller,
                  hint: "email_phone_number".translate(context),
                  typeInput: const [TypeInput.phone, TypeInput.email],
                ),
                const SizedBox(height: 20),
                Text("enter_email_phone_reset_password".translate(context)),
                const SizedBox(height: 50),
                customButton(
                  text: "continue".translate(context),
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      sendApi();
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

  Future sendApi() async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final response = await apiService.resetPassword(controller.text);
    } catch (e) {
      print(e);
    }
  }
}
