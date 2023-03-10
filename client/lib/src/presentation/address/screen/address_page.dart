import 'package:flutter/material.dart';

import '../../../controls/route_function.dart';
import '../../add_address/screen/add_address_page.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: const Text(
          "Địa chỉ của bạn",
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
      ),
      body: SafeArea(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(createRoute(
                  screen: const AddAddressPage(),
                  begin: const Offset(1, 0),
                ));
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                  children: const [
                    Icon(Icons.add),
                    SizedBox(width: 10),
                    Text("Thêm địa chỉ"),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios_outlined)
                  ],
                ),
              ),
            ),
            const Divider(),
            Expanded(
                child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text("Trần Ngọc Tiến"),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(createRoute(
                                screen: const AddAddressPage(),
                                begin: const Offset(1, 0),
                              ));
                            },
                            child: const Text("Chỉnh sửa"),
                          ),
                        ],
                      ),
                      const Text("0334161287"),
                      const Text("Lê Văn Việt"),
                      const Text("Hồ Chí Minh, Việt Nam"),
                    ],
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
