import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:coffee/src/presentation/voucher/widgets/app_bar_general.dart';
import 'package:coffee/src/presentation/voucher/widgets/ticket_widget.dart';
import 'package:flutter/material.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({Key? key, this.onPress}) : super(key: key);

  final Function(String id)? onPress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      appBar:
          AppBarGeneral(title: "your_offer".translate(context), elevation: 0),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(10),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: TicketWidget(
                onPress: () {
                  onPress!("id");
                },
                title: "Mua 1 tặng 1",
                image: "assets/banner.jpg",
                date: DateTime(2023, 12, 31),
              ),
            );
          },
        ),
      ),
    );
  }
}
