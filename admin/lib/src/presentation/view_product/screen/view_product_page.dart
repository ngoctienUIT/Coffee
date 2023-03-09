import 'package:flutter/material.dart';

import '../../../data/data_app.dart';

class ViewProductPage extends StatefulWidget {
  const ViewProductPage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<ViewProductPage> createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {
  final _controller = ScrollController();
  bool isTop = true;
  int sizeIndex = 0;

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
    );
  }

  Widget appBar() {
    return SliverAppBar(
      backgroundColor:
          isTop ? Colors.transparent : const Color.fromRGBO(177, 40, 48, 1),
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.close,
          color: isTop ? Colors.black : Colors.white,
          size: 30,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.edit,
            color: isTop ? const Color.fromRGBO(177, 40, 48, 1) : Colors.white,
          ),
        ),
      ],
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
          ],
        ),
      ),
    );
  }
}
