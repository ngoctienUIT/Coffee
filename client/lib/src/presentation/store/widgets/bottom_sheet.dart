import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee/src/core/utils/constants/app_colors.dart';
import 'package:coffee/src/core/utils/constants/app_strings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../data/models/store.dart';
import '../../login/widgets/custom_button.dart';
import 'item_loading.dart';

void showStoreBottomSheet(
    BuildContext context, Store store, VoidCallback onPress) {
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
                      imageUrl: linkStore,
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
                text: AppLocalizations.of(context).orderHere.toUpperCase(),
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

Widget nameAndAddress(Store store) {
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
      GestureDetector(
        onTap: () async {
          String googleUrl =
              "https://www.google.com/maps/search/?api=1&query=${store.getAddress()}";
          if (await canLaunchUrlString(googleUrl)) {
            await launchUrlString(googleUrl,
                mode: LaunchMode.externalApplication);
          }
        },
        child: Text(
            "${store.address1} - ${store.address2} - ${store.address3} - ${store.address4}"),
      ),
      const Divider(),
    ],
  );
}

Widget phoneAndHour(BuildContext context, Store store) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: () async {
          if (await canLaunchUrlString('tel:${store.hotlineNumber}')) {
            await launchUrlString('tel:${store.hotlineNumber}');
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              const Icon(Icons.call, color: AppColors.statusBarColor),
              const SizedBox(width: 5),
              Text(store.hotlineNumber.toString()),
            ],
          ),
        ),
      ),
      const Divider(),
      const SizedBox(height: 10),
      Text(
        AppLocalizations.of(context).hour,
        style: const TextStyle(
          color: Color(0xff4F2C1F),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Widget timeline(Store store) {
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
