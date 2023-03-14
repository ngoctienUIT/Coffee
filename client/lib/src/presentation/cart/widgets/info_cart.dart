import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:coffee/src/presentation/cart/widgets/item_info.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../controls/function/route_function.dart';
import '../../address/screen/address_page.dart';

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
                Text("${"method".translate(context)}:"),
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
                    child: Text("at_table".translate(context)),
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
                    child: Text("bring_back".translate(context)),
                  ),
                )
              ],
            ),
          ),
          const Divider(),
          InkWell(
            onTap: () {},
            child: itemInfo(Icons.alarm, "Hôm nay - 17:15"),
          ),
          const Divider(),
          InkWell(
            onTap: () {
              Navigator.of(context).push(createRoute(
                screen: const AddressPage(),
                begin: const Offset(1, 0),
              ));
            },
            child: itemInfo(Icons.phone, "0334161287"),
          ),
          const Divider(),
          InkWell(
            onTap: () {
              Navigator.of(context).push(createRoute(
                screen: const AddressPage(),
                begin: const Offset(1, 0),
              ));
            },
            child: itemInfo(Icons.location_on, "Hồ Chí Minh, Việt Nam"),
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
                    decoration: InputDecoration(
                      hintText: "order_notes".translate(context),
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
