import 'package:flutter/material.dart';

import '../../other/widgets/group_item_other.dart';
import '../../other/widgets/item_other.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Cài Đặt",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            groupItemOther("Cài Đặ̣t Tài Khoản", [
              itemOther("Xóa tài khoản", Icons.delete_forever, () {}),
            ]),
            groupItemOther("Bảo Mật", [
              itemOther("Thay đổi mật khẩu", Icons.lock, () {}),
            ]),
          ],
        ),
      ),
    );
  }
}
