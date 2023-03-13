import 'package:coffee_admin/src/controls/extension/string_extension.dart';
import 'package:coffee_admin/src/presentation/order/widgets/header_order.dart';
import 'package:coffee_admin/src/presentation/view_order/screen/view_order_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../controls/function/route_function.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController _orderController;

  @override
  void initState() {
    _orderController = TabController(length: 5, vsync: this);
    _orderController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      body: SafeArea(
        child: Column(
          children: [
            HeaderOrderPage(tabController: _orderController),
            const SizedBox(height: 10),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {},
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(createRoute(
                          screen: const ViewOrderPage(),
                          begin: const Offset(1, 0),
                        ));
                      },
                      child: itemOrder(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemOrder() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        // margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset("assets/vietnam.png", height: 40),
                const SizedBox(width: 10),
                const Text(
                  "Tên cửa hàng",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Image.asset("assets/tea.png", height: 100),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Tên khách hàng",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(DateFormat("hh:mm - dd/MM/yyyy")
                            .format(DateTime.now())),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "${"total_order".translate(context)}: 500.000đ",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "${"into_money".translate(context)}: 500.000đ",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              children: [
                Text("delivery_status".translate(context)),
                const Spacer(),
                Text(
                  "delivered".translate(context).toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
