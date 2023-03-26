import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/on_will_pop.dart';
import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../core/utils/enum/enums.dart';
import '../../forgot_password/screen/forgot_password_page.dart';
import '../../main/screen/main_page.dart';
import '../../signup/screen/signup_page.dart';
import '../../signup/widgets/custom_text_input.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_password_input.dart';
import '../widgets/social_login_button.dart';

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
  bool isRemember = false;
  bool isContinue = false;
  bool canPop = false;
  bool hide = true;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        isRemember = value.getBool("isRemember") ?? false;
        phoneController.text = value.getString("username") ?? "";
        passwordController.text = value.getString("password") ?? "";
      });
    });
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

  Future saveLogin() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isRemember', isRemember);
    prefs.setString('username', isRemember ? phoneController.text : "");
    prefs.setString('password', isRemember ? passwordController.text : "");
  }

  @override
  Widget build(BuildContext context) {
    canPop = ModalRoute.of(context)!.canPop;
    return Scaffold(
      backgroundColor: AppColors.bgCreamColor,
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
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 35,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      ClipOval(
                        child: Image.asset(AppImages.imgLogo, height: 200),
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
                        children: [
                          Checkbox(
                            value: isRemember,
                            onChanged: (value) =>
                                setState(() => isRemember = value!),
                          ),
                          Text("remember_login".translate(context)),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(createRoute(
                                screen: const ForgotPasswordPage(),
                                begin: const Offset(1, 0),
                              ));
                            },
                            child: Text(
                                "${"forgot_password".translate(context)}?"),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      customButton(
                        text: "continue".translate(context).toUpperCase(),
                        isOnPress: isContinue,
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            saveLogin();
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
                      const Spacer(),
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
      ),
    );
  }
}
