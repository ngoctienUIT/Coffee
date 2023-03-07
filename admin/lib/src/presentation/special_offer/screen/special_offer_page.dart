import 'package:coffee_admin/src/presentation/add_special_offer/screen/add_special_offer.dart';
import 'package:flutter/material.dart';

import '../../../controls/function/route_function.dart';
import '../widgets/build_special_offer.dart';

class SpecialOfferPage extends StatelessWidget {
  const SpecialOfferPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Tất cả khuyến mãi",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: const BuildGridSpecialOffer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(createRoute(
            screen: const AddSpecialOffer(),
            begin: const Offset(0, 1),
          ));
        },
        backgroundColor: const Color.fromRGBO(177, 40, 48, 1),
        child: const Icon(Icons.add),
      ),
    );
  }
}
