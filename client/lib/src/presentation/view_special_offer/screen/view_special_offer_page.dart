import 'package:flutter/material.dart';

class ViewSpecialOfferPage extends StatelessWidget {
  const ViewSpecialOfferPage({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/banner.jpg",
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  fit: BoxFit.fitWidth,
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(90),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Mô tả"),
                    Text("Nội dung"),
                    SizedBox(height: 50),
                    Divider(),
                    Text("Điều khoản và điều kiện"),
                    Text("Các điểu khoản"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
