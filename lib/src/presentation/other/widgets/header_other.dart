import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';

class HeaderOtherPage extends StatefulWidget {
  const HeaderOtherPage({Key? key}) : super(key: key);

  @override
  State<HeaderOtherPage> createState() => _HeaderOtherPageState();
}

class _HeaderOtherPageState extends State<HeaderOtherPage> {
  final List<String> items = [
    'Tiếng Việt',
    'English',
  ];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(177, 40, 48, 1),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: CustomDropdownButton2(
              hint: 'Tiếng Việt',
              icon: const Icon(
                Icons.keyboard_arrow_down_outlined,
                color: Colors.white,
              ),
              iconSize: 25,
              dropdownItems: items,
              value: selectedValue,
              buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                border: Border.all(color: Colors.white),
              ),
              onChanged: (value) {
                setState(() => selectedValue = value);
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.asset(
                  "assets/coffee_logo.jpg",
                  height: 80,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      children: const [
                        Text(
                          "Trần Ngọc Tiến",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        VerticalDivider(
                          color: Colors.white,
                          width: 2,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "THÀNH VIÊN",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "DRIPS: 0",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
