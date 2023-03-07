import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../add_product/widgets/bottom_pick_image.dart';
import '../../add_voucher/widgets/custom_picker_widget.dart';
import '../../login/widgets/custom_text_input.dart';
import '../../product/widgets/description_line.dart';

class AddSpecialOffer extends StatefulWidget {
  const AddSpecialOffer({Key? key}) : super(key: key);

  @override
  State<AddSpecialOffer> createState() => _AddSpecialOfferState();
}

class _AddSpecialOfferState extends State<AddSpecialOffer> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime startDate = DateTime.now();
  DateTime finishDate = DateTime.now();
  File? image;

  @override
  void dispose() {
    titleController.dispose();
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
          "Thêm khuyến mãi",
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
                descriptionLine(text: "Tiêu đề khuyến mãi"),
                const SizedBox(height: 10),
                customTextInput(
                  controller: titleController,
                  hint: "Tiêu đề khuyến mãi",
                  title: "tiêu đề",
                ),
                const SizedBox(height: 10),
                descriptionLine(text: "Ngày bắt đầu"),
                const SizedBox(height: 10),
                CustomPickerWidget(
                  text: DateFormat("dd/MM/yyyy").format(startDate),
                  onPress: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: startDate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null && picked != startDate) {
                      setState(() => startDate = picked);
                    }
                  },
                ),
                const SizedBox(height: 10),
                descriptionLine(text: "Ngày bắt đầu"),
                const SizedBox(height: 10),
                CustomPickerWidget(
                  text: DateFormat("dd/MM/yyyy").format(finishDate),
                  onPress: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: finishDate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null && picked != finishDate) {
                      setState(() => finishDate = picked);
                    }
                  },
                ),
                const SizedBox(height: 10),
                descriptionLine(text: "Nội dung khuyến mãi"),
                const SizedBox(height: 10),
                customTextInput(
                  controller: contentController,
                  hint: "Mô tả khuyến mãi",
                  title: "mô tả khuyến mãi",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
