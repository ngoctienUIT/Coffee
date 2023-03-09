import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoCart extends StatefulWidget {
  const InfoCart({Key? key}) : super(key: key);

  @override
  State<InfoCart> createState() => _InfoCartState();
}

class _InfoCartState extends State<InfoCart> {
  TextEditingController noteController = TextEditingController();
  Color selectedColor = const Color.fromRGBO(177, 40, 48, 1);
  Color unselectedColor = const Color.fromRGBO(204, 204, 204, 1);
  bool isBringBack = false;

  @override
  Widget build(BuildContext context) {
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
                      backgroundColor:
                          isBringBack ? unselectedColor : selectedColor,
                    ),
                    onPressed: () => setState(() => isBringBack = false),
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
                      backgroundColor:
                          isBringBack ? selectedColor : unselectedColor,
                    ),
                    onPressed: () => setState(() => isBringBack = true),
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
              children: [
                const Icon(FontAwesomeIcons.fileLines),
                const SizedBox(width: 5),
                Expanded(
                  child: TextField(
                    controller: noteController,
                    decoration: const InputDecoration(
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
}
