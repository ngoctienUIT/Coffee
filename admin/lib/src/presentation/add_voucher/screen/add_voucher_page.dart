import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../add_product/widgets/bottom_pick_image.dart';
import '../../login/widgets/custom_text_input.dart';
import '../../product/widgets/description_line.dart';
import '../widgets/custom_picker_widget.dart';

class AddVoucherPage extends StatefulWidget {
  const AddVoucherPage({Key? key}) : super(key: key);

  @override
  State<AddVoucherPage> createState() => _AddVoucherPageState();
}

class _AddVoucherPageState extends State<AddVoucherPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController specialController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  File? image;

  @override
  void dispose() {
    titleController.dispose();
    specialController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Thêm voucher",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.close_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {}
            },
            child: const Text("Lưu"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 10),
                InkWell(
                  onTap: () => showMyBottomSheet(context, (image) {
                    setState(() => this.image = image);
                  }),
                  child: image == null
                      ? Image.asset("assets/banner.jpg",
                          height: 150, width: 150)
                      : Image.file(image!, height: 150, width: 150),
                ),
                const SizedBox(height: 30),
                descriptionLine(text: "Tiêu đề voucher"),
                const SizedBox(height: 10),
                customTextInput(
                  controller: titleController,
                  hint: "Tiêu đề voucher",
                  title: "tiêu đề",
                ),
                const SizedBox(height: 10),
                descriptionLine(text: "Ngày hết hạn"),
                const SizedBox(height: 10),
                CustomPickerWidget(
                  text: DateFormat("dd/MM/yyyy").format(selectedDate),
                  onPress: () => selectDate(),
                ),
                descriptionLine(text: "Khuyến mãi"),
                const SizedBox(height: 10),
                customTextInput(
                  controller: specialController,
                  hint: "100.000đ",
                  keyboardType: TextInputType.number,
                  title: "khuyến mãi",
                ),
                const SizedBox(height: 10),
                descriptionLine(text: "Nội dung voucher"),
                const SizedBox(height: 10),
                customTextInput(
                  controller: contentController,
                  hint: "Nội dung voucher",
                  title: "nội dung voucher",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }
}
