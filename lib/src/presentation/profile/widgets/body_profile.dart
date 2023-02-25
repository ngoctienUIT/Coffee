import 'package:coffee/src/presentation/home/widgets/description_line.dart';
import 'package:flutter/material.dart';

class BodyProfilePage extends StatelessWidget {
  const BodyProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 200,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  descriptionLine("Thông Tin Chung"),
                  const Spacer(),
                  TextButton(onPressed: () {}, child: const Text("Sửa")),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Họ",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12)),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Tên",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12)),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Giới Tính",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "11/02/2002",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              descriptionLine("Số Điện Thoại"),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "11/02/2002",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              descriptionLine("Email"),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "11/02/2002",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              descriptionLine("Tài Khoản Liên Kết"),
            ],
          ),
        ),
      ),
    );
  }
}
