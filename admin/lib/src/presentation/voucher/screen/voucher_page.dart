import 'package:flutter/material.dart';

import '../../../controls/route_function.dart';
import '../../add_voucher/screen/add_voucher_page.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(createRoute(
            screen: const AddVoucherPage(),
            begin: const Offset(0, 1),
          ));
        },
        backgroundColor: const Color.fromRGBO(177, 40, 48, 1),
        child: const Icon(Icons.add),
      ),
    );
  }
}
