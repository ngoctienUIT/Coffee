import 'package:flutter/material.dart';

class TotalPayment extends StatelessWidget {
  const TotalPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tính tiền",
              style: TextStyle(fontSize: 16),
            ),
            const Divider(),
            Row(
              children: const [Text("Tổng phụ"), Spacer(), Text("54.000đ")],
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Text("Mã giảm giá"),
                Spacer(),
                Text("54.000đ")
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: const [Text("Tổng cộng"), Spacer(), Text("54.000đ")],
            ),
          ],
        ),
      ),
    );
  }
}
