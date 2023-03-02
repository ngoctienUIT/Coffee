import 'package:coffee/src/presentation/info/screen/info_page.dart';
import 'package:coffee/src/presentation/login/screen/login_page.dart';
import 'package:coffee/src/presentation/setting/screen/setting_page.dart';
import 'package:flutter/material.dart';

import '../../login/widgets/custom_button.dart';
import '../../profile/screen/profile_page.dart';
import 'group_item_other.dart';
import 'item_other.dart';

class BodyOtherPage extends StatelessWidget {
  const BodyOtherPage({Key? key}) : super(key: key);

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
            groupItemOther("Tài khoản", [
              itemOther("Hồ sơ", Icons.person, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ));
              }),
              const Divider(),
              itemOther("Cài đặt", Icons.settings, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingPage(),
                    ));
              })
            ]),
            groupItemOther("Tương tác", [
              itemOther("Hoạt động", Icons.local_activity, () {}),
            ]),
            groupItemOther("Thông tin chung", [
              itemOther("Chính sách", Icons.file_copy, () {}),
              const Divider(),
              itemOther("Thông tin ứng dụng", Icons.info, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InfoPage(),
                    ));
              })
            ]),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: customButton("Đăng xuất", () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ));
              }),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
