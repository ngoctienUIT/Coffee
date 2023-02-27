import 'package:flutter/material.dart';

class HeaderProfilePage extends StatefulWidget {
  const HeaderProfilePage({Key? key}) : super(key: key);

  @override
  State<HeaderProfilePage> createState() => _HeaderProfilePageState();
}

class _HeaderProfilePageState extends State<HeaderProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(177, 40, 48, 1),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
                child: ClipOval(
                  child: Image.asset(
                    "assets/coffee_logo.jpg",
                    height: 80,
                  ),
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
                          "DRIPS: 0",
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
