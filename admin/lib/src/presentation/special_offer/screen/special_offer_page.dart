import 'package:coffee_admin/src/presentation/add_special_offer/screen/add_special_offer.dart';
import 'package:flutter/material.dart';

import '../../../controls/route_function.dart';

class SpecialOfferPage extends StatelessWidget {
  const SpecialOfferPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
