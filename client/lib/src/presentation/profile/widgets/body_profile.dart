import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:coffee/src/presentation/home/widgets/description_line.dart';
import 'package:coffee/src/presentation/order/widgets/title_bottom_sheet.dart';
import 'package:coffee/src/presentation/profile/widgets/custom_picker_widget.dart';
import 'package:coffee/src/presentation/profile/widgets/gender_widget.dart';
import 'package:coffee/src/presentation/signup/widgets/custom_text_input.dart';
import 'package:flutter/material.dart';

class BodyProfilePage extends StatefulWidget {
  const BodyProfilePage({Key? key}) : super(key: key);

  @override
  State<BodyProfilePage> createState() => _BodyProfilePageState();
}

class _BodyProfilePageState extends State<BodyProfilePage> {
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  bool checkEdit = false;
  bool isPick = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        color: Color.fromRGBO(241, 241, 241, 1),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  descriptionLine(text: "general_info".translate(context)),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      if (checkEdit) {
                        if (_formKey.currentState!.validate()) {
                          setState(() => checkEdit = !checkEdit);
                        }
                      } else {
                        setState(() => checkEdit = !checkEdit);
                      }
                    },
                    child: Text(
                      (checkEdit ? "save" : "edit").translate(context),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextInput(
                      controller: surnameController,
                      hint: "surname".translate(context),
                      typeInput: const [TypeInput.text],
                      checkEdit: checkEdit,
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
                      checkEdit: checkEdit,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomPickerWidget(
                checkEdit: checkEdit,
                text: "gender".translate(context),
                onPress: () => showMyBottomSheet(context),
              ),
              const SizedBox(height: 10),
              CustomPickerWidget(
                checkEdit: checkEdit,
                text: "birthday".translate(context),
                onPress: () => selectDate(),
              ),
              const SizedBox(height: 10),
              descriptionLine(text: "phone_number".translate(context)),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: phoneController,
                hint: "phone_number".translate(context),
                typeInput: const [TypeInput.phone],
                checkEdit: checkEdit,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              descriptionLine(text: "Email"),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: emailController,
                typeInput: const [TypeInput.email],
                hint: "Email",
                checkEdit: checkEdit,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              descriptionLine(text: "affiliate_account".translate(context)),
            ],
          ),
        ),
      ),
    );
  }

  void selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  void showMyBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (context) {
        return Container(
          height: 250,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              titleBottomSheet(
                "choose_gender".translate(context),
                () => Navigator.pop(context),
              ),
              const Divider(color: Colors.black),
              GenderWidget(
                gender: "male".translate(context),
                image: "assets/male.png",
                onPress: () {
                  setState(() => isPick = true);
                  Navigator.pop(context);
                },
                isPick: isPick,
              ),
              GenderWidget(
                gender: "female".translate(context),
                image: "assets/female.png",
                onPress: () {
                  setState(() => isPick = false);
                  Navigator.pop(context);
                },
                isPick: !isPick,
              ),
            ],
          ),
        );
      },
    );
  }
}
