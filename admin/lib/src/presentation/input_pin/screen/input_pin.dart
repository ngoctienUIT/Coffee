import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/function/route_function.dart';
import '../../../core/function/server_status.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../core/utils/enum/enums.dart';
import '../../../domain/api_service.dart';
import '../../forgot_password/widgets/app_bar_general.dart';
import '../../login/widgets/custom_button.dart';
import '../../new_password/screen/new_password_page.dart';
import '../../signup/widgets/custom_text_input.dart';

class InputPin extends StatefulWidget {
  const InputPin({Key? key, required this.resetCredential}) : super(key: key);

  final String resetCredential;

  @override
  State<InputPin> createState() => _InputPinState();
}

class _InputPinState extends State<InputPin> {
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
                const Text("Nhập vào mã PIN"),
                const SizedBox(height: 20),
                CustomTextInput(
                  controller: controller,
                  hint: "PIN",
                  typeInput: const [TypeInput.text],
                ),
                const SizedBox(height: 20),
                const Text(
                    "Nhập vào mã PIN đã được gửi vào email của bạn"),
                const SizedBox(height: 50),
                customButton(
                  text: "continue".translate(context),
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      sendApi().then((value) {
                        if (value) {
                          Navigator.of(context).pushReplacement(createRoute(
                            screen: NewPasswordPage(
                                resetCredential: widget.resetCredential),
                            begin: const Offset(1, 0),
                          ));
                        }
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

  Future<bool> sendApi() async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      return (await apiService.validateResetTokenClient(
              widget.resetCredential, controller.text))
          .data;
    } catch (e) {
      print(serverStatus(e));
      return false;
    }
  }
}
