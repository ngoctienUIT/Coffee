import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:coffee/src/presentation/product/widgets/choose_size.dart';
import 'package:coffee/src/presentation/signup/widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../data/data_app.dart';
import '../widgets/choose_quantity.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  TextEditingController noteController = TextEditingController();
  final numberFormat = NumberFormat.currency(locale: "vi_VI");
  final _controller = ScrollController();
  int sizeIndex = 0;
  bool isTop = true;
  int number = 1;

  @override
  void initState() {
    _controller.addListener(() {
      setState(() => isTop =
          _controller.position.pixels != _controller.position.maxScrollExtent);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          // physics: const BouncingScrollPhysics(),
          controller: _controller,
          slivers: [
            appBar(),
            SliverToBoxAdapter(
              child: Image.asset(
                listSellingProducts[widget.index]["image"]!,
                height: 300,
                width: 300,
              ),
            ),
            body()
          ],
        ),
      ),
      bottomSheet: bottom(),
    );
  }

  Widget appBar() {
    return SliverAppBar(
      backgroundColor:
          isTop ? Colors.transparent : const Color.fromRGBO(177, 40, 48, 1),
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.close, color: isTop ? Colors.black : Colors.white),
      ),
      expandedHeight: 0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: AnimatedOpacity(
          opacity: isTop ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 300),
          child: Text(
            listSellingProducts[widget.index]["name"]!,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
        expandedTitleScale: 1.2,
      ),
    );
  }

  Widget body() {
    return SliverToBoxAdapter(
      child: AnimatedContainer(
        height: MediaQuery.of(context).size.height - 90,
        decoration: BoxDecoration(
          borderRadius: isTop
              ? const BorderRadius.vertical(top: Radius.circular(20))
              : null,
          color: const Color.fromRGBO(241, 241, 241, 1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        duration: const Duration(milliseconds: 300),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  listSellingProducts[widget.index]["name"]!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  listSellingProducts[widget.index]["price"]!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(listSellingProducts[widget.index]["content"]!),
            const SizedBox(height: 20),
            Row(
              children: [
                chooseSize("S", sizeIndex == 0, () {
                  setState(() => sizeIndex = 0);
                }),
                const SizedBox(width: 10),
                chooseSize("M", sizeIndex == 1, () {
                  setState(() => sizeIndex = 1);
                }),
                const SizedBox(width: 10),
                chooseSize("L", sizeIndex == 2, () {
                  setState(() => sizeIndex = 2);
                }),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(color: Colors.black),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(FontAwesomeIcons.fileLines),
                const SizedBox(width: 5),
                Text(
                  "note".translate(context),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 5),
                Text("optional".translate(context)),
              ],
            ),
            const SizedBox(height: 15),
            CustomTextInput(
              controller: noteController,
              hint: "note".translate(context),
              colorBorder: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }

  Widget bottom() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 75,
      child: Row(
        children: [
          chooseQuantity(number, (value) => setState(() => number = value)),
          const SizedBox(width: 20),
          Expanded(
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(177, 40, 48, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "${"add".translate(context)} ${numberFormat.format(number * 30000)}",
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
