import 'package:coffee/src/core/utils/constants/app_colors.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/login/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/enum/enums.dart';
import '../../home/widgets/description_line.dart';
import '../../signup/widgets/custom_text_input.dart';

class RegisterInfoPage extends StatefulWidget {
  const RegisterInfoPage({Key? key}) : super(key: key);

  @override
  State<RegisterInfoPage> createState() => _RegisterInfoPageState();
}

class _RegisterInfoPageState extends State<RegisterInfoPage> {
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("customer_info".translate(context)),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                descriptionLine(
                  text: "personal_info".translate(context),
                  color: AppColors.statusBarColor,
                  margin: EdgeInsets.zero,
                  fontSize: 16,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextInput(
                        controller: surnameController,
                        hint: "surname".translate(context),
                        typeInput: const [TypeInput.text],
                        title: "surname".translate(context).toLowerCase(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomTextInput(
                        controller: nameController,
                        hint: "name".translate(context),
                        title: "name".translate(context).toLowerCase(),
                        typeInput: const [TypeInput.text],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                CustomTextInput(
                  controller: phoneController,
                  hint: "phone_number".translate(context),
                  typeInput: const [TypeInput.phone],
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 10),
                CustomTextInput(
                  controller: emailController,
                  typeInput: const [TypeInput.email],
                  hint: "Email",
                  keyboardType: TextInputType.emailAddress,
                ),
                const Spacer(),
                customButton(
                  isOnPress: true,
                  text: "next".translate(context).toUpperCase(),
                  onPress: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
