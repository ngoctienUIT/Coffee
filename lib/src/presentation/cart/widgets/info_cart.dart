import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget infoCart() {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Text("Phương thức:"),
              const Spacer(),
              SizedBox(
                height: 40,
                width: 90,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color.fromRGBO(177, 40, 48, 1),
                  ),
                  onPressed: () {},
                  child: const Text("Tại Bàn"),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 40,
                width: 90,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color.fromRGBO(204, 204, 204, 1),
                  ),
                  onPressed: () {},
                  child: const Text("Mang về"),
                ),
              )
            ],
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: const [
              Icon(Icons.alarm),
              SizedBox(width: 5),
              Text("Hôm nay - 17:15"),
              Spacer(),
              Icon(Icons.arrow_forward_ios_rounded)
            ],
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: const [
              Icon(FontAwesomeIcons.fileLines),
              SizedBox(width: 5),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Ghi chú đơn hàng",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
