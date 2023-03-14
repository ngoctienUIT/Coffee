import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../controls/function/route_function.dart';
import '../../add_address/screen/add_address_page.dart';

class ItemAddress extends StatelessWidget {
  const ItemAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Trần Ngọc Tiến",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(createRoute(
                        screen: const AddAddressPage(),
                        begin: const Offset(1, 0),
                      ));
                    },
                    child: Text("edit".translate(context)),
                  ),
                ],
              ),
              const Text("0334161287"),
              const SizedBox(height: 5),
              const Text("Lê Văn Việt"),
              const SizedBox(height: 5),
              const Text("Hồ Chí Minh, Việt Nam"),
            ],
          ),
        ),
        const Divider(color: Colors.black26, height: 1),
      ],
    );
  }
}
