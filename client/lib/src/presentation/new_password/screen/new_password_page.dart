import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/function/route_function.dart';
import '../../../domain/api_service.dart';
import '../../coupon/widgets/app_bar_general.dart';
import '../../login/screen/login_page.dart';
import '../../login/widgets/custom_button.dart';
import '../../login/widgets/custom_password_input.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({Key? key, required this.resetCredential})
      : super(key: key);

  final String resetCredential;

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isHide = false;

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarGeneral(elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "change_password".translate(context),
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text("password_needs_characters".translate(context)),
              const SizedBox(height: 10),
              CustomPasswordInput(
                controller: newPasswordController,
                hint: "enter_new_password".translate(context),
                hide: isHide,
                onPress: () => setState(() => isHide = !isHide),
              ),
              const SizedBox(height: 10),
              CustomPasswordInput(
                controller: confirmPasswordController,
                confirmPassword: newPasswordController.text,
                hint: "confirm_password".translate(context),
                hide: isHide,
                onPress: () => setState(() => isHide = !isHide),
              ),
              const Spacer(),
              customButton(
                text: "change_password".translate(context),
                isOnPress: true,
                onPress: () {
                  setState(() {});
                  if (_formKey.currentState!.validate()) {
                    sendApi().then((value) {
                      Navigator.of(context).pushAndRemoveUntil(
                        createRoute(
                          screen: const LoginPage(),
                          begin: const Offset(0, 1),
                        ),
                        (route) => false,
                      );
                    });
                  }
                },
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }

  Future sendApi() async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      await apiService.issueNewPasswordUser(
          widget.resetCredential, newPasswordController.text);
    } catch (e) {
      print(e);
    }
  }
}
