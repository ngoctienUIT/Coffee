import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/address/widgets/add_address_widget.dart';
import 'package:coffee/src/presentation/address/widgets/item_address.dart';
import 'package:coffee/src/presentation/voucher/widgets/app_bar_general.dart';
import 'package:flutter/material.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGeneral(
        title: "your_address".translate(context),
        elevation: 1,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const AddAddressWidget(),
            const Divider(),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 10),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const ItemAddress();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
