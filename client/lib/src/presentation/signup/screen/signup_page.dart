import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:coffee/src/presentation/login/screen/login_page.dart';
import 'package:coffee/src/presentation/signup/widgets/custom_text_input.dart';
import 'package:coffee/src/presentation/signup/widgets/pick_country_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../controls/function/route_function.dart';
import '../../login/widgets/custom_button.dart';
import '../../login/widgets/social_login_button.dart';
import '../../main/screen/main_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String selectedValue = "+84";
  bool isContinue = false;
  final List<String> items = [
    '+84',
    '+85',
    '+86',
    '+87',
  ];

  @override
  void initState() {
    phoneController.addListener(() {
      if (phoneController.text.isNotEmpty) {
        setState(() => isContinue = true);
      } else {
        setState(() => isContinue = false);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
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
                  const SizedBox(height: 10),
                  Text(
                    "start_journey".translate(context),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(
                        width: 80,
                        height: 50,
                        child: PickCountryNumber(
                          selectedValue: selectedValue,
                          items: items,
                          onChange: (value) {
                            setState(() => selectedValue = value as String);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomTextInput(
                          controller: phoneController,
                          hint: "phone_number".translate(context),
                          typeInput: const [TypeInput.phone],
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[0-9a-zA-Z]")),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  customButton(
                    text: "continue".translate(context),
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
                  // const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${"already_have_account".translate(context)}?"),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(createRoute(
                            screen: const LoginPage(),
                            begin: const Offset(0, 1),
                          ));
                        },
                        child: Text("login".translate(context)),
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
