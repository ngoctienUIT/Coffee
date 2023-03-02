import 'package:coffee/src/presentation/forgot_password/screen/forgot_password_page.dart';
import 'package:coffee/src/presentation/login/widgets/custom_button.dart';
import 'package:coffee/src/presentation/login/widgets/custom_password_input.dart';
import 'package:coffee/src/presentation/login/widgets/or_widget.dart';
import 'package:coffee/src/presentation/login/widgets/social_login_button.dart';
import 'package:coffee/src/presentation/signup/screen/signup_page.dart';
import 'package:coffee/src/presentation/signup/widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../main/screen/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool hide = true;

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
                  const SizedBox(height: 20),
                  const Text(
                    "Chào mừng trở lại",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  customTextInput(
                    controller: phoneController,
                    hint: "Số điện thoại",
                    keyboardType: TextInputType.phone,
                    typeInput: [TypeInput.phone],
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordPage(),
                              ));
                        },
                        child: const Text("Quên mật khẩu?"),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  customButton("TIẾP TỤC", () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainPage(),
                          ));
                    }
                  }),
                  const SizedBox(height: 20),
                  orWidget(),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialLoginButton(
                        icon: FontAwesomeIcons.google,
                        color: Colors.red,
                        onPress: () {},
                      ),
                      SocialLoginButton(
                        icon: FontAwesomeIcons.facebook,
                        color: Colors.blue,
                        onPress: () {},
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Khách hàng mới?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpPage(),
                              ));
                        },
                        child: const Text("Tạo một tài khoản"),
                      )
                    ],
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
