import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../data/data_app.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
        elevation: 0,
        title: const Text(
          "Giỏ hàng",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(onPressed: () {}, child: const Text("Xóa giỏ hàng")),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Text("Phương thức:"),
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
                                    const Color.fromRGBO(177, 40, 48, 1),
                              ),
                              onPressed: () {},
                              child: const Text("Tại Bàn"),
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
                                    const Color.fromRGBO(204, 204, 204, 1),
                              ),
                              onPressed: () {},
                              child: const Text("Mang về"),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: const [
                          Icon(Icons.alarm),
                          SizedBox(width: 5),
                          Text("Hôm nay - 17:15"),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: const [
                          Icon(FontAwesomeIcons.fileLines),
                          SizedBox(width: 5),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Ghi chú đơn hàng",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Row(
                        children: [
                          const Text("Danh sách sản phẩm"),
                          const Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: const Text("Thêm sản phẩm"),
                          )
                        ],
                      ),
                    ),
                    const Divider(),
                    ListView.builder(
                      padding: const EdgeInsets.only(bottom: 10),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: listSellingProducts.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              if (index != 0)
                                const Divider(indent: 10, endIndent: 10),
                              Row(
                                children: [
                                  const Text("(1x)"),
                                  const SizedBox(width: 5),
                                  Text(listSellingProducts[index]["name"]!),
                                  const Spacer(),
                                  Text(listSellingProducts[index]["price"]!),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: Row(
                        children: const [
                          Text("Tạm tính"),
                          Spacer(),
                          Text("54.000đ")
                        ],
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Text("Khuyến mãi"),
                          const Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: const Text("Thêm Khuyến mãi"),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Row(
                    children: const [
                      Text("Tổng cộng"),
                      Spacer(),
                      Text("54.000đ")
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 200),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 150,
        color: Colors.white,
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.credit_card_rounded),
                      label: const Text("Thẻ nội địa"),
                    ),
                  ),
                  const VerticalDivider(
                    color: Colors.black,
                    indent: 5,
                    endIndent: 5,
                  ),
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.card_membership),
                      label: const Text("Khuyến mãi"),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color.fromRGBO(177, 40, 48, 1),
                ),
                onPressed: () {},
                child: const Text("Đặt hàng (54.000đ)"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
