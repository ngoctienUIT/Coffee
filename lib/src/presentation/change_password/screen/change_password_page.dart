import 'package:coffee/src/presentation/login/widgets/custom_button.dart';
import 'package:coffee/src/presentation/login/widgets/custom_password_input.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isContinue = false;
  bool hide = true;

  @override
  void initState() {
    oldPasswordController.addListener(() => checkEmpty());
    newPasswordController.addListener(() => checkEmpty());
    confirmPasswordController.addListener(() => checkEmpty());
    super.initState();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

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
        child: Form(
          key: _formKey,
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
              customPasswordInput(
                controller: oldPasswordController,
                hint: "Nhập mật khẩu cũ",
                hide: hide,
                onPress: () => setState(() => hide = !hide),
              ),
              const SizedBox(height: 10),
              customPasswordInput(
                controller: newPasswordController,
                hint: "Nhập mật khẩu mới",
                hide: hide,
                onPress: () => setState(() => hide = !hide),
              ),
              const SizedBox(height: 10),
              customPasswordInput(
                controller: confirmPasswordController,
                confirmPassword: newPasswordController.text,
                hint: "Xác nhận mật khẩu",
                hide: hide,
                onPress: () => setState(() => hide = !hide),
              ),
              const Spacer(),
              customButton(
                text: "Thay đổi mật khẩu",
                isOnPress: isContinue,
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                  }
                },
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }

  void checkEmpty() {
    if (oldPasswordController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      setState(() => isContinue = true);
    } else {
      setState(() => isContinue = false);
    }
  }
}
