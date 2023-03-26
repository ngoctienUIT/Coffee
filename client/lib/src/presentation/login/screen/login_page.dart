import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:coffee/src/presentation/forgot_password/screen/forgot_password_page.dart';
import 'package:coffee/src/presentation/login/widgets/custom_button.dart';
import 'package:coffee/src/presentation/login/widgets/custom_password_input.dart';
import 'package:coffee/src/presentation/login/widgets/social_login_button.dart';
import 'package:coffee/src/presentation/signup/screen/signup_page.dart';
import 'package:coffee/src/presentation/signup/widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../controls/function/on_will_pop.dart';
import '../../../controls/function/route_function.dart';
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
  DateTime? currentBackPressTime;
  bool isContinue = false;
  bool canPop = false;
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
    canPop = ModalRoute.of(context)!.canPop;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 227, 178, 1),
      appBar: canPop
          ? AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            )
          : null,
      body: WillPopScope(
        onWillPop: () => onWillPop(
          action: (now) => currentBackPressTime = now,
          currentBackPressTime: currentBackPressTime,
        ),
        child: SafeArea(
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
                    Text(
                      "welcome_back".translate(context),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextInput(
                      controller: phoneController,
                      hint: "phone_number".translate(context),
                      keyboardType: TextInputType.phone,
                      typeInput: const [TypeInput.phone],
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("[0-9a-zA-Z]")),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomPasswordInput(
                      controller: passwordController,
                      hint: "password".translate(context),
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
                          child:
                              Text("${"forgot_password".translate(context)}?"),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    customButton(
                      text: "continue".translate(context).toUpperCase(),
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
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(thickness: 1, color: Colors.black54),
                        ),
                        const SizedBox(width: 10),
                        Text("or".translate(context)),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Divider(thickness: 1, color: Colors.black54),
                        ),
                      ],
                    ),
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
                        Text("${"new_customer".translate(context)}?"),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(createRoute(
                              screen: const SignUpPage(),
                              begin: const Offset(0, 1),
                            ));
                          },
                          child: Text("create_account".translate(context)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
