import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StorePage extends StatelessWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(90),
          child: ClipOval(child: Image.asset("assets/coffee_logo.jpg")),
        ),
        actions: [
          IconButton(
            onPressed: () {},
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
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 0.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2),
                      ),
                      hintText: "Tìm kiếm tên món ăn",
                      suffixIcon: const Icon(Icons.search),
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
            )
          ],
        ),
      ),
    );
  }
}
