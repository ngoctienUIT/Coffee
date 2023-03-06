import 'package:flutter/material.dart';

import '../../../controls/route_function.dart';
import '../../info/screen/info_page.dart';
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
            groupItemOther("Thông tin chung", [
              itemOther("Chính sách", Icons.file_copy, () {}),
              const Divider(),
              itemOther("Thông tin ứng dụng", Icons.info, () {
                Navigator.of(context).push(createRoute(
                  screen: const InfoPage(),
                  begin: const Offset(1, 0),
                ));
              })
            ]),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
