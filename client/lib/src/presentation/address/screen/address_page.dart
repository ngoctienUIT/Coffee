import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../controls/function/route_function.dart';
import '../../add_address/screen/add_address_page.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          "your_address".translate(context),
          style: const TextStyle(color: Colors.black),
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
                  children: [
                    const Icon(Icons.add),
                    const SizedBox(width: 10),
                    Text("add_address".translate(context)),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios_outlined)
                  ],
                ),
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 10),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Trần Ngọc Tiến",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(createRoute(
                                      screen: const AddAddressPage(),
                                      begin: const Offset(1, 0),
                                    ));
                                  },
                                  child: Text("edit".translate(context)),
                                ),
                              ],
                            ),
                            const Text("0334161287"),
                            const SizedBox(height: 5),
                            const Text("Lê Văn Việt"),
                            const SizedBox(height: 5),
                            const Text("Hồ Chí Minh, Việt Nam"),
                          ],
                        ),
                      ),
                      const Divider(color: Colors.black26, height: 1),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
