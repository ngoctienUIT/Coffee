import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/cart/widgets/item_info.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../add_address/screen/add_address_page.dart';

class InfoCart extends StatefulWidget {
  const InfoCart({Key? key}) : super(key: key);

  @override
  State<InfoCart> createState() => _InfoCartState();
}

class _InfoCartState extends State<InfoCart> {
  TextEditingController noteController = TextEditingController();
  Color selectedColor = AppColors.statusBarColor;
  Color unselectedColor = AppColors.unselectedColor;
  bool isBringBack = false;

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
                screen: const AddAddressPage(),
                begin: const Offset(1, 0),
              ));
            },
            child: itemInfo(Icons.phone, "0334161287"),
          ),
          const Divider(),
          InkWell(
            onTap: () {
              Navigator.of(context).push(createRoute(
                screen: const AddAddressPage(),
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
