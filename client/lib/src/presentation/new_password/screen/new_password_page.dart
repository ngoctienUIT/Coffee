import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../domain/api_service.dart';
import '../../login/widgets/custom_button.dart';
import '../../login/widgets/custom_password_input.dart';
import '../../voucher/widgets/app_bar_general.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  TextEditingController newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                hide: true,
                onPress: () {},
              ),
              const Spacer(),
              customButton(
                text: "change_password".translate(context),
                isOnPress: true,
                onPress: () {
                  if (_formKey.currentState!.validate()) {}
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
      bool check = await apiService.validateResetTokenClient(
          widget.token, newPasswordController.text);
    } catch (e) {
      print(e);
    }
  }
}
