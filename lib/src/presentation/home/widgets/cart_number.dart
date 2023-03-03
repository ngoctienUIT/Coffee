import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget cartNumber(int number) {
  return Stack(
    alignment: Alignment.center,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Icon(
          FontAwesomeIcons.basketShopping,
          color: Colors.white,
        ),
      ),
      Positioned(
        top: 5,
        right: 0,
        child: Material(
          color: Colors.red.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 3,
            ),
            child: Text(
              "$number",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
