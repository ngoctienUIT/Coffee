import 'package:coffee/src/presentation/voucher/widgets/ticket_widget.dart';
import 'package:flutter/material.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({Key? key, this.onPress}) : super(key: key);

  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Ưu đãi của bạn",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
                  onPress!();
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
