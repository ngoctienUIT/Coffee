import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../controls/route_function.dart';
import '../../main/screen/main_page.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_password_input.dart';
import '../widgets/custom_text_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isContinue = false;
  bool hide = true;

  @override
  void initState() {
    passwordController.addListener(() => checkEmpty());
    phoneController.addListener(() => checkEmpty());
    super.initState();
  }

  void checkEmpty() {
    if (phoneController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      setState(() => isContinue = true);
    } else {
      setState(() => isContinue = false);
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 227, 178, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ClipOval(
                    child: Image.asset("assets/coffee_logo.jpg", height: 200),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Chào mừng Admin",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  customTextInput(
                    controller: phoneController,
                    hint: "Username",
                    typeInput: [TypeInput.text],
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                    ],
                  ),
                  const SizedBox(height: 10),
                  customPasswordInput(
                    controller: passwordController,
                    hint: "Mật khẩu",
                    onPress: () => setState(() => hide = !hide),
                    hide: hide,
                  ),
                  const SizedBox(height: 30),
                  customButton(
                    text: "TIẾP TỤC",
                    isOnPress: isContinue,
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pushReplacement(createRoute(
                          screen: const MainPage(),
                          begin: const Offset(0, 1),
                        ));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
