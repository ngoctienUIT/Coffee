import 'package:coffee/src/data/models/store.dart';
import 'package:coffee/src/presentation/signup/widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../controls/route_function.dart';
import '../../profile/screen/profile_page.dart';
import '../../search/screen/search_page.dart';

class StorePage extends StatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  TextEditingController searchAddressController = TextEditingController();

  @override
  void dispose() {
    searchAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).push(createRoute(
              screen: const ProfilePage(),
              begin: const Offset(1, 0),
            ));
          },
          borderRadius: BorderRadius.circular(90),
          child: ClipOval(child: Image.asset("assets/coffee_logo.jpg")),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(createRoute(
                screen: const SearchPage(),
                begin: const Offset(1, 0),
              ));
            },
            icon: const Icon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.grey,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: customTextInput(
                      controller: searchAddressController,
                      hint: "Tìm kiếm địa chỉ",
                      radius: 90,
                      contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      textInputAction: TextInputAction.search,
                      textStyle: const TextStyle(fontSize: 13),
                      suffixIcon: const Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.map),
                  label: const Text("Bản đồ"),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 15,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: itemStore(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget itemStore() {
    final store = Store(
      image:
          "https://www.highlandscoffee.com.vn/vnt_upload/news/02_2020/83739091_2845644318849727_1748210367038750720_o_1.png",
      name: "Sala 2",
      address: "Quận 2 - Hồ Chí Minh",
      phone: "0334168888",
      startDay: const TimeOfDay(hour: 7, minute: 0),
      endDay: const TimeOfDay(hour: 22, minute: 0),
    );
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Image.network(
              store.image,
              height: 100,
              width: 100,
              fit: BoxFit.fitHeight,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  store.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(store.address),
                Row(
                  children: [
                    const Icon(Icons.phone),
                    const SizedBox(width: 5),
                    Text(store.phone),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(52, 175, 84, 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(store.checkOpen() ? "Mở" : "Đóng"),
                    ),
                    const SizedBox(width: 5),
                    Text(store.rangeTime())
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
