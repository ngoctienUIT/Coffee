import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/data/models/address.dart';
import 'package:coffee/src/domain/repositories/store/store_response.dart';
import 'package:coffee/src/presentation/cart/widgets/item_info.dart';
import 'package:coffee/src/presentation/store/screen/store_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../add_address/screen/add_address_page.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';

class InfoCart extends StatefulWidget {
  const InfoCart({Key? key, this.store, this.address}) : super(key: key);

  final StoreResponse? store;
  final Address? address;

  @override
  State<InfoCart> createState() => _InfoCartState();
}

class _InfoCartState extends State<InfoCart> {
  TextEditingController noteController = TextEditingController();
  Color selectedColor = AppColors.statusBarColor;
  Color unselectedColor = AppColors.unselectedColor;
  bool isBringBack = false;
  Address? address;
  StoreResponse? store;

  @override
  void initState() {
    store = widget.store;
    address = widget.address;
    super.initState();
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

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
                SizedBox(
                  height: 40,
                  width: 90,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor:
                          isBringBack ? unselectedColor : selectedColor,
                    ),
                    onPressed: () {
                      setState(() => isBringBack = false);
                    },
                    child: Text("at_table".translate(context)),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 40,
                  width: 90,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor:
                          isBringBack ? selectedColor : unselectedColor,
                    ),
                    onPressed: () {
                      setState(() => isBringBack = true);
                    },
                    child: Text("bring_back".translate(context)),
                  ),
                )
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
                  child: TextField(
                    controller: noteController,
                    decoration: InputDecoration(
                      hintText: "order_notes".translate(context),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget atTable() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(createRoute(
          screen: StorePage(
            storeID: store == null ? null : store!.storeId,
            isPick: true,
            onPress: (store) => setState(() {
              this.store = store;
              context.read<CartBloc>().add(
                  ChangeMethod(isBringBack: false, storeID: store.storeId));
            }),
          ),
          begin: const Offset(1, 0),
        ));
      },
      child: Padding(
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
                    store != null ? store!.storeName! : "",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(store != null ? store!.hotlineNumber! : ""),
                  const SizedBox(height: 5),
                  Text(store == null
                      ? ""
                      : "${store!.address1}, ${store!.address2}, ${store!.address3}, ${store!.address4},"),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded)
          ],
        ),
      ),
    );
  }

  Widget bringBack() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(createRoute(
              screen: AddAddressPage(
                address: address,
                onSave: (address) => setState(() {
                  this.address = address;
                  context
                      .read<CartBloc>()
                      .add(ChangeMethod(isBringBack: true, address: address));
                }),
              ),
              begin: const Offset(1, 0),
            ));
          },
          child: itemInfo(Icons.phone, address == null ? "" : address!.phone),
        ),
        const Divider(),
        InkWell(
          onTap: () {
            Navigator.of(context).push(createRoute(
              screen: AddAddressPage(
                address: address,
                onSave: (address) => setState(() {
                  this.address = address;
                  context
                      .read<CartBloc>()
                      .add(ChangeMethod(isBringBack: true, address: address));
                }),
              ),
              begin: const Offset(1, 0),
            ));
          },
          child: itemInfo(
            Icons.location_on,
            address == null ? "" : address!.getAddress(),
          ),
        ),
      ],
    );
  }
}
