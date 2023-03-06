import 'package:flutter/material.dart';

Widget membershipCard() {
  return Container(
    height: 200,
    width: double.infinity,
    color: const Color.fromRGBO(241, 227, 178, 1),
    padding: const EdgeInsets.all(10),
    child: Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(177, 40, 48, 1),
              Color.fromRGBO(233, 126, 136, 1),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Trần Ngọc Tiến",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Thành viên",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Spacer(),
            Text(
              "DRIPS: 0",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    ),
  );
}
