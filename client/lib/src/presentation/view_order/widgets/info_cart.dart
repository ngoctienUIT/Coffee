import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:coffee/src/data/remote/response/order/order_response.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/utils/constants/constants.dart';
import '../../cart/widgets/item_info.dart';

class InfoCart extends StatelessWidget {
  const InfoCart({Key? key, required this.isBringBack, required this.order})
      : super(key: key);

  final bool isBringBack;
  final OrderResponse order;
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
                Text("${AppLocalizations.of(context).method}:"),
                const Spacer(),
                Container(
                  height: 40,
                  width: 90,
                  decoration: BoxDecoration(
                    color: isBringBack ? unselectedColor : selectedColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context).atTable,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 40,
                  width: 90,
                  decoration: BoxDecoration(
                    color: isBringBack ? selectedColor : unselectedColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context).bringBack,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                      ? AppLocalizations.of(context).notHave
                      : order.orderCustomerNote!),
                ),
              ],
            ),
          ),
        ],
      ),
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
                  order.selectedPickupStore?.storeName! ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(order.selectedPickupStore?.hotlineNumber! ?? ""),
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
    return itemInfo(
      Icons.location_on,
      "${order.address1}, ${order.address2}, ${order.address3}, ${order.address4},",
    );
  }
}
