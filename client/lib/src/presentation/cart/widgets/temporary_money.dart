import 'package:flutter/material.dart';

Widget temporaryMoney() {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Row(
            children: const [Text("Tạm tính"), Spacer(), Text("54.000đ")],
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Text("Khuyến mãi"),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text("Thêm Khuyến mãi"),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
