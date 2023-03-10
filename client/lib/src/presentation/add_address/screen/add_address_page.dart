import 'package:coffee/src/presentation/signup/widgets/custom_text_input.dart';
import 'package:flutter/material.dart';

class AddAddressPage extends StatelessWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
        elevation: 1,
        title: const Text(
          "Chỉnh sửa địa chỉ",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete, color: Colors.black),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Thông tin liên hệ"),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  customTextInput(hint: "Trần Ngọc Tiến"),
                  customTextInput(hint: "0334161287"),
                ],
              ),
            ),
            Text("Thông tin địa chỉ"),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  customTextInput(hint: "Việt Nam"),
                  customTextInput(hint: "Thành Phố"),
                  customTextInput(hint: "Quận/Huyện"),
                  customTextInput(hint: "Xã/Phường"),
                  customTextInput(hint: "Địa chỉ"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
