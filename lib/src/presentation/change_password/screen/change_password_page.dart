import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool hide = true;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Thay đổi mật khẩu",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("Mật khẩu cần dài ít nhất 8 ký tự"),
            const SizedBox(height: 10),
            TextFormField(
              obscureText: hide,
              decoration: InputDecoration(
                hintText: "Nhập mật khẩu cũ",
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12)),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  onPressed: () => setState(() => hide = !hide),
                  icon: Icon(hide ? Icons.visibility : Icons.visibility_off),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              obscureText: hide,
              decoration: InputDecoration(
                hintText: "Mật khẩu mới",
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12)),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  onPressed: () => setState(() => hide = !hide),
                  icon: Icon(hide ? Icons.visibility : Icons.visibility_off),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              obscureText: hide,
              decoration: InputDecoration(
                hintText: "Xác nhập mật khẩu",
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                ),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  onPressed: () => setState(() => hide = !hide),
                  icon: Icon(hide ? Icons.visibility : Icons.visibility_off),
                ),
              ),
            ),
            const Spacer(),
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
                child: const Text("Thay đổi mật khẩu"),
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}