import 'package:flutter/material.dart';

import 'group_item_other.dart';
import 'item_other.dart';

class BodyOtherPage extends StatelessWidget {
  const BodyOtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 240,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              groupItemOther("Tài khoản", [
                itemOther("Hồ sơ", Icons.person, () {}),
                const Divider(),
                itemOther("Cài đặt", Icons.settings, () {})
              ]),
              groupItemOther("Tương tác", [
                itemOther("Hoạt động", Icons.local_activity, () {}),
              ]),
              groupItemOther("Thông tin chung", [
                itemOther("Chính sách", Icons.file_copy, () {}),
                const Divider(),
                itemOther("Thông tin ứng dụng", Icons.info, () {})
              ]),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("Đăng xuất"),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
