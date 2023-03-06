import 'package:flutter/material.dart';

import '../../login/widgets/custom_button.dart';
import '../../product/widgets/title_bottom_sheet.dart';
import 'language_widget.dart';

class HeaderOtherPage extends StatelessWidget {
  const HeaderOtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(177, 40, 48, 1),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const Spacer(),
              InkWell(
                onTap: () {
                  showMyBottomSheet(context);
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        "Tiếng Việt",
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 10),
          ClipOval(
            child: Image.asset("assets/coffee_logo.jpg", height: 100),
          ),
          const SizedBox(height: 10),
          const Text(
            "Admin",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
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
              titleBottomSheet(
                "Lựa chọn ngôn ngữ",
                () => Navigator.pop(context),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(width: 20),
                  Expanded(
                    child: languageWidget(
                      image: "assets/vietnam.png",
                      text: "Tiếng Việt",
                      onPress: () {},
                      isPick: true,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: languageWidget(
                      image: "assets/english.png",
                      text: "English",
                      onPress: () {},
                      isPick: false,
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(10),
                child: customButton(
                  text: "Đồng ý",
                  isOnPress: true,
                  onPress: () {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
