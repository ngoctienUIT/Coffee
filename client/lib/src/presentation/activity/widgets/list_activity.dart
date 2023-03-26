import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../controls/function/route_function.dart';
import '../../view_order/screen/view_order_page.dart';

class ListActivity extends StatelessWidget {
  const ListActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(createRoute(
                screen: const ViewOrderPage(),
                begin: const Offset(0, 1),
              ));
            },
            child: itemActivity(),
          );
        },
      ),
    );
  }

  Widget itemActivity() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Image.asset("assets/tea.png", height: 50),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text(
                        "Tại cửa hàng",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "105.000đ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text("Đang giao"),
                      const Spacer(),
                      Text(
                        DateFormat("hh:mm - dd/MM/yyyy").format(DateTime.now()),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(width: 5),
            const Icon(Icons.arrow_forward_ios_outlined)
          ],
        ),
      ),
    );
  }
}
