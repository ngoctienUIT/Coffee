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

import '../../../controls/route_function.dart';
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
                          Navigator.of(context).push(createRoute(
                            screen: const ForgotPasswordPage(),
                            begin: const Offset(1, 0),
                          ));
                        },
                        child: const Text("Quên mật khẩu?"),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
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
                          Navigator.of(context).pushReplacement(createRoute(
                            screen: const SignUpPage(),
                            begin: const Offset(0, 1),
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
