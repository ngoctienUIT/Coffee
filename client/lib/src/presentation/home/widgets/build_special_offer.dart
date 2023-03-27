import 'package:coffee/src/presentation/view_special_offer/screen/view_special_offer_page.dart';
import 'package:flutter/material.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/app_strings.dart';

class BuildListSpecialOffer extends StatelessWidget {
  const BuildListSpecialOffer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: listSpecialOffer.length,
        itemBuilder: (context, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              Navigator.of(context).push(createRoute(
                screen: ViewSpecialOfferPage(index: index),
                begin: const Offset(0, 1),
              ));
            },
            child: buildSpecialOffer(index),
          );
        },
      ),
    );
  }

  Widget buildSpecialOffer(int index) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Card(
        child: SizedBox(
          width: 170,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Image.asset(
                  listSpecialOffer[index]["image"]!,
                  height: 150,
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    listSpecialOffer[index]["content"]!,
                    maxLines: 2,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    listSpecialOffer[index]["time"]!,
                    style: const TextStyle(
                      color: Color.fromRGBO(122, 122, 122, 1),
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
