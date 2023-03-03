import 'package:coffee/src/data/data_app.dart';
import 'package:coffee/src/presentation/home/widgets/description_line.dart';
import 'package:coffee/src/presentation/order/widgets/bottom_sheet_order.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../controls/route_function.dart';
import '../../search/screen/search_page.dart';
import '../../signup/widgets/custom_text_input.dart';
import '../widgets/grid_item_order.dart';
import '../widgets/list_item_order.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  TextEditingController searchFoodController = TextEditingController();
  late TabController _productController;
  bool check = true;

  @override
  void dispose() {
    searchFoodController.dispose();
    super.dispose();
  }

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
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                height: 40,
                child: customTextInput(
                  controller: searchFoodController,
                  hint: "Tìm kiếm tên món ăn",
                  radius: 90,
                  contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  textInputAction: TextInputAction.search,
                  textStyle: const TextStyle(fontSize: 13),
                  backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
                  onPress: () {
                    Navigator.of(context).push(createRoute(
                      screen: const SearchPage(),
                      begin: const Offset(1, 0),
                    ));
                  },
                  suffixIcon: const Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: Colors.grey,
                  ),
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
                    onTap: () => setState(() => check = true),
                    child: Icon(
                      Icons.menu,
                      color: check ? Colors.red : Colors.grey,
                      size: 35,
                    ),
                  ),
                  InkWell(
                    onTap: () => setState(() => check = false),
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
