import 'package:coffee_admin/src/controls/extension/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../controls/function/route_function.dart';
import '../../add_voucher/screen/add_voucher_page.dart';
import '../widgets/ticket_widget.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "all_vouchers".translate(context),
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {},
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(10),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TicketWidget(
                  onPress: () {},
                  title: "Mua 1 tặng 1",
                  image: "assets/banner.jpg",
                  date: DateTime(2023, 12, 31),
                ),
              );
            },
          ),
        ),
      ),
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
