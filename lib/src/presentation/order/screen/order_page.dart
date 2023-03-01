import 'package:coffee/src/data/data_app.dart';
import 'package:coffee/src/presentation/home/widgets/description_line.dart';
import 'package:coffee/src/presentation/order/widgets/bottom_sheet_order.dart';
import 'package:flutter/material.dart';

import '../widgets/grid_item_order.dart';
import '../widgets/list_item_order.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController _productController;
  bool check = true;

  @override
  void initState() {
    _productController =
        TabController(length: listItemProduct.length, vsync: this);
    _productController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 0.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  hintText: "Tìm kiếm tên món ăn",
                  suffixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(
              height: 115,
              child: TabBar(
                controller: _productController,
                physics: const BouncingScrollPhysics(),
                isScrollable: true,
                labelColor: Colors.black87,
                // labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelColor: const Color.fromRGBO(45, 216, 198, 1),
                // unselectedLabelStyle: const TextStyle(fontSize: 16),
                indicatorColor: Colors.green,
                tabs: List.generate(listItemProduct.length, (index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 3.7,
                    child: Column(
                      children: [
                        Image.asset(
                          listItemProduct[index]["image"]!,
                          height: 70,
                        ),
                        Text(
                          listItemProduct[index]["name"]!.toUpperCase(),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  descriptionLine(
                    text: listItemProduct[_productController.index]["name"]!
                        .toUpperCase(),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      setState(() => check = true);
                    },
                    child: Icon(
                      Icons.menu,
                      color: check ? Colors.red : Colors.grey,
                      size: 35,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() => check = false);
                    },
                    child: Icon(
                      Icons.grid_view_rounded,
                      color: check ? Colors.grey : Colors.red,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: check ? const ListItemOrder() : gridItemOrder(),
              ),
            ),
            const SizedBox(height: 56),
          ],
        ),
      ),
      bottomSheet: const BottomSheetOrder(),
    );
  }
}
