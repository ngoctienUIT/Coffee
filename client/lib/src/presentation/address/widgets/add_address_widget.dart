import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../controls/function/route_function.dart';
import '../../add_address/screen/add_address_page.dart';

class AddAddressWidget extends StatelessWidget {
  const AddAddressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(createRoute(
          screen: const AddAddressPage(),
          begin: const Offset(1, 0),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Row(
          children: [
            const Icon(Icons.add),
            const SizedBox(width: 10),
            Text("add_address".translate(context)),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_outlined)
          ],
        ),
      ),
    );
  }
}
