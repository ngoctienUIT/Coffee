import 'package:coffee/src/data/data_app.dart';
import 'package:coffee/src/presentation/cart/screen/cart_page.dart';
import 'package:coffee/src/presentation/home/widgets/description_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  final List<String> items = [
    'Tại bàn',
    'Mang về',
  ];

  String? selectedValue;

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
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
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
            Row(
              children: [
                descriptionLine(
                  listItemProduct[_productController.index]["name"]!
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
            const SizedBox(height: 10),
            Expanded(child: check ? const ListItemOrder() : gridItemOrder()),
            const SizedBox(height: 56),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(color: Color.fromRGBO(177, 40, 48, 1)),
        child: Row(
          children: [
            const Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () => showMyBottomSheet(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Tại bàn",
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartPage(),
                    ));
              },
              child: const Icon(
                FontAwesomeIcons.basketShopping,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  void showMyBottomSheet() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      context: context,
      builder: (context) {
        return Container(
          height: 400,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Icon(Icons.close, size: 35),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Chọn phương thức giao hàng",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 100,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Image.asset("assets/coffee_logo.jpg", height: 90),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            SizedBox(height: 10),
                            Text(
                              "Tại bàn",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Text("Vui lòng chọn quán"),
                            SizedBox(height: 10),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 100,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Image.asset("assets/coffee_logo.jpg", height: 90),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          SizedBox(height: 10),
                          Text(
                            "Mang về",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text("Vui lòng chọn quán"),
                          SizedBox(height: 10),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
