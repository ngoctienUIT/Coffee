import 'package:coffee/src/presentation/forgot_password/screen/forgot_password_page.dart';
import 'package:coffee/src/presentation/login/widgets/social_login_button.dart';
import 'package:coffee/src/presentation/signup/screen/signup_page.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 227, 178, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
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
                TextFormField(
                  controller: phoneController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                  ],
                  style: const TextStyle(fontSize: 16),
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: "Số Điện Thoại",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  style: const TextStyle(fontSize: 16),
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Mật Khẩu",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPasswordPage(),
                            ));
                      },
                      child: const Text("Quên mật khẩu?"),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainPage(),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "TIẾP TỤC",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: const [
                    Expanded(
                        child: Divider(thickness: 1, color: Colors.black54)),
                    SizedBox(width: 10),
                    Text("Hoặc"),
                    SizedBox(width: 10),
                    Expanded(
                        child: Divider(thickness: 1, color: Colors.black54)),
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
    );
  }
}
