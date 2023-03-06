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
                  descriptionLine(text: "Thông Tin Chung"),
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
                    child: Text(checkEdit ? "Lưu" : "Sửa"),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: customTextInput(
                        controller: surnameController,
                        hint: "Họ",
                        typeInput: [TypeInput.text],
                        checkEdit: checkEdit,
                        title: "họ"),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: customTextInput(
                      controller: nameController,
                      hint: "Tên",
                      title: "tên",
                      typeInput: [TypeInput.text],
                      checkEdit: checkEdit,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomPickerWidget(
                checkEdit: checkEdit,
                text: "Giới tính",
                onPress: () => showMyBottomSheet(context),
              ),
              const SizedBox(height: 10),
              CustomPickerWidget(
                checkEdit: checkEdit,
                text: "Ngày sinh",
                onPress: () => selectDate(),
              ),
              const SizedBox(height: 10),
              descriptionLine(text: "Số Điện Thoại"),
              const SizedBox(height: 10),
              customTextInput(
                controller: phoneController,
                hint: "Số điện thoại",
                typeInput: [TypeInput.phone],
                checkEdit: checkEdit,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              descriptionLine(text: "Email"),
              const SizedBox(height: 10),
              customTextInput(
                controller: emailController,
                typeInput: [TypeInput.email],
                hint: "Email",
                checkEdit: checkEdit,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              descriptionLine(text: "Tài Khoản Liên Kết"),
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
                "Chọn giới tính",
                () => Navigator.pop(context),
              ),
              const Divider(color: Colors.black),
              genderWidget(
                gender: "Nam",
                image: "assets/male.png",
                onPress: () {
                  setState(() => isPick = true);
                  Navigator.pop(context);
                },
                isPick: isPick,
              ),
              genderWidget(
                gender: "Nữ",
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
