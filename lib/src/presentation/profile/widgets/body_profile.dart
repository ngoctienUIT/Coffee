import 'package:coffee/src/presentation/home/widgets/description_line.dart';
import 'package:coffee/src/presentation/profile/widgets/custom_picker_widget.dart';
import 'package:coffee/src/presentation/profile/widgets/gender_widget.dart';
import 'package:coffee/src/presentation/profile/widgets/text_input_profile.dart';
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
  DateTime selectedDate = DateTime.now();
  bool checkEdit = false;

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
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                descriptionLine(text: "Thông Tin Chung"),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() => checkEdit = !checkEdit);
                  },
                  child: Text(checkEdit ? "Lưu" : "Sửa"),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: textInputProfile(
                    controller: surnameController,
                    hint: "Họ",
                    checkEdit: checkEdit,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: textInputProfile(
                    controller: nameController,
                    hint: "Tên",
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
            textInputProfile(
              controller: phoneController,
              hint: "Số điện thoại",
              checkEdit: checkEdit,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),
            descriptionLine(text: "Email"),
            const SizedBox(height: 10),
            textInputProfile(
              controller: emailController,
              hint: "Email",
              checkEdit: checkEdit,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            descriptionLine(text: "Tài Khoản Liên Kết"),
          ],
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
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Text(
                      "Chọn giới tính",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Positioned(
                      left: 0,
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Icon(Icons.close, size: 35),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.black),
              genderWidget("Nam", "assets/male.png", () {
                Navigator.pop(context);
              }),
              genderWidget("Nữ", "assets/female.png", () {
                Navigator.pop(context);
              }),
            ],
          ),
        );
      },
    );
  }
}
