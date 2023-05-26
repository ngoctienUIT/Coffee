import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:coffee_admin/src/presentation/view_order/widgets/item_type.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../core/utils/constants/constants.dart';
import '../../../data/models/user.dart';
import '../../../domain/repositories/order/order_response.dart';

class InfoCart extends StatelessWidget {
  const InfoCart({
    Key? key,
    required this.isBringBack,
    required this.order,
    required this.user,
  }) : super(key: key);

  final bool isBringBack;
  final OrderResponse order;
  final User? user;
  final Color selectedColor = AppColors.statusBarColor;
  final Color unselectedColor = AppColors.unselectedColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Text("${"method".translate(context)}:"),
                const Spacer(),
                itemType(
                  "at_table".translate(context),
                  isBringBack ? unselectedColor : selectedColor,
                ),
                const SizedBox(width: 10),
                itemType(
                  "bring_back".translate(context),
                  isBringBack ? selectedColor : unselectedColor,
                ),
              ],
            ),
          ),
          const Divider(),
          userInfo(),
          const Divider(),
          isBringBack ? bringBack() : atTable(),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(FontAwesomeIcons.fileLines),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(order.orderCustomerNote == null
                      ? "not_have".translate(context)
                      : order.orderCustomerNote!),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget userInfo() {
    return Column(
      children: [
        itemInfo(Icons.person,
            user != null ? user!.displayName : "Người dùng Coffee"),
        const Divider(),
        GestureDetector(
          onTap: () async {
            if (await canLaunchUrlString('tel:${user!.phoneNumber}')) {
              await launchUrlString('tel:${user!.phoneNumber}');
            }
          },
          child: itemInfo(Icons.phone, user != null ? user!.phoneNumber : ""),
        ),
      ],
    );
  }

  Widget atTable() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Icon(Icons.store),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.selectedPickupStore != null
                      ? order.selectedPickupStore!.storeName!
                      : "",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(order.selectedPickupStore != null
                    ? order.selectedPickupStore!.hotlineNumber!
                    : ""),
                const SizedBox(height: 5),
                Text(order.selectedPickupStore == null
                    ? ""
                    : "${order.selectedPickupStore!.address1}, ${order.selectedPickupStore!.address2}, ${order.selectedPickupStore!.address3}, ${order.selectedPickupStore!.address4},"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bringBack() {
    String address =
        "${order.address1}, ${order.address2}, ${order.address3}, ${order.address4}";
    return GestureDetector(
      onTap: () async {
        String googleUrl =
            "https://www.google.com/maps/search/?api=1&query=$address";
        if (await canLaunchUrlString(googleUrl)) {
          await launchUrlString(googleUrl,
              mode: LaunchMode.externalApplication);
        }
      },
      child: itemInfo(Icons.location_on, address),
    );
  }

  Widget itemInfo(IconData icon, String content) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 5),
          Expanded(child: Text(content)),
        ],
      ),
    );
  }
}
