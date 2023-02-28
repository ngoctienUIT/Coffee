import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../cart/screen/cart_page.dart';

class BottomSheetOrder extends StatelessWidget {
  const BottomSheetOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            onTap: () => showMyBottomSheet(context),
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
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ));
            },
            child: Container(
              height: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    FontAwesomeIcons.basketShopping,
                    color: Colors.white,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text("0"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showMyBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (context) {
        return Container(
          height: 350,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Text(
                      "Chọn phương thức giao hàng",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Positioned(
                      left: 0,
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Icon(Icons.close, size: 35),
                      ),
                    ),
                  ],
                ),
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
