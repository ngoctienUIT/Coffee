import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../cart/widgets/item_info.dart';

class InfoCart extends StatelessWidget {
  const InfoCart({Key? key, required this.isBringBack}) : super(key: key);

  final bool isBringBack;
  final Color selectedColor = const Color.fromRGBO(177, 40, 48, 1);
  final Color unselectedColor = const Color.fromRGBO(204, 204, 204, 1);

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
                Text("${"method".translate(context)}:"),
                const Spacer(),
                Container(
                  height: 40,
                  width: 90,
                  decoration: BoxDecoration(
                    color: isBringBack ? unselectedColor : selectedColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "at_table".translate(context),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 40,
                  width: 90,
                  decoration: BoxDecoration(
                    color: isBringBack ? selectedColor : unselectedColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "bring_back".translate(context),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          itemInfo(Icons.alarm, "Hôm nay - 17:15"),
          const Divider(),
          itemInfo(Icons.phone, "0334161287"),
          const Divider(),
          itemInfo(Icons.location_on, "Hồ Chí Minh, Việt Nam"),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(FontAwesomeIcons.fileLines),
                const SizedBox(width: 5),
                Expanded(child: Text("not_have".translate(context))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
