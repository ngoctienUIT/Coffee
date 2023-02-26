import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../data/data_app.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final _controller = ScrollController();
  bool isTop = true;

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
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.close, color: Colors.black),
      ),
      expandedHeight: 0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: AnimatedOpacity(
          opacity: isTop ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 300),
          child: Text(
            listSellingProducts[widget.index]["name"]!,
            style: const TextStyle(color: Colors.black),
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
          color: Colors.grey,
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
                SizedBox(
                  height: 50,
                  width: 90,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "S",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 50,
                  width: 90,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "M",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 50,
                  width: 90,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "L",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
            const Divider(),
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
          SizedBox(
            width: 50,
            height: 50,
            child: OutlinedButton(
              onPressed: () {},
              child: const Icon(FontAwesomeIcons.minus),
            ),
          ),
          const SizedBox(width: 50, child: Center(child: Text("1"))),
          SizedBox(
            width: 50,
            height: 50,
            child: OutlinedButton(
              onPressed: () {},
              child: const Icon(FontAwesomeIcons.plus),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90),
                  ),
                ),
                onPressed: () {},
                child: const Text("Thêm 35.000đ"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
