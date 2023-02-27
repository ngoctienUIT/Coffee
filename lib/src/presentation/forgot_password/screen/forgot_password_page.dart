import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                "assets/coffee_logo.jpg",
                height: 200,
              ),
            ),
            const Text("Quên mật khẩu của bạn"),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Email/Số điện thoại",
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
                "Nhập vào địa chỉ email hoặc số điện thoại bạn đã sử dụng để đăng nhập vào ứng dụng của chúng tôi để đặt lại mật khẩu"),
            const SizedBox(height: 50),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color.fromRGBO(177, 40, 48, 1),
                ),
                onPressed: () {},
                child: const Text("Tiếp tục"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
