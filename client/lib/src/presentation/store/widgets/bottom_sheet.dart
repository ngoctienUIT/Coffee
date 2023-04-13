import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee/src/core/utils/constants/app_strings.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../domain/repositories/store/store_response.dart';
import '../../login/widgets/custom_button.dart';
import 'item_loading.dart';

void showStoreBottomSheet(
    BuildContext context, StoreResponse store, VoidCallback onPress) {
  showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          "https://www.highlandscoffee.com.vn/vnt_upload/news/02_2020/83739091_2845644318849727_1748210367038750720_o_1.png",
                      placeholder: (context, url) =>
                          itemLoading(double.infinity, double.infinity, 0),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    const SizedBox(height: 20),
                    nameAndAddress(store),
                    phoneAndHour(context, store),
                    timeline(store),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: customButton(
                text: "order_here".translate(context).toUpperCase(),
                isOnPress: true,
                onPress: onPress,
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget nameAndAddress(StoreResponse store) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        store.storeName.toString(),
        style: const TextStyle(
          color: Color(0xff4F2C1F),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 20),
      Text(
          "${store.address1} - ${store.address2} - ${store.address3} - ${store.address4}"),
      const Divider(),
    ],
  );
}

Widget phoneAndHour(BuildContext context, StoreResponse store) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            const Icon(Icons.call),
            const SizedBox(width: 5),
            Text(store.hotlineNumber.toString()),
          ],
        ),
      ),
      const Divider(),
      const SizedBox(height: 10),
      Text(
        "hour".translate(context),
        style: const TextStyle(
          color: Color(0xff4F2C1F),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Widget timeline(StoreResponse store) {
  return ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.symmetric(vertical: 20),
    shrinkWrap: true,
    itemCount: dayInWeek.length,
    itemBuilder: (context, index) {
      return Column(
        children: [
          if (index != 0) const Divider(indent: 15, endIndent: 15),
          Row(
            children: [
              Text(
                dayInWeek[index],
                style: const TextStyle(
                  color: Color(0xff4F2C1F),
                ),
              ),
              const Spacer(),
              Text(
                "${store.openingHour} - ${store.closingHour}",
                style: const TextStyle(
                  color: Color(0xff4F2C1F),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
