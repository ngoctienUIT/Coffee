import 'dart:io';

import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
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
        title: Text(
          "add_voucher".translate(context),
          style: const TextStyle(color: Colors.black),
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
            child: Text("save".translate(context)),
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
                descriptionLine(text: "voucher_title".translate(context)),
                const SizedBox(height: 10),
                CustomTextInput(
                  controller: titleController,
                  hint: "voucher_title".translate(context),
                  title: "title".translate(context).toLowerCase(),
                ),
                const SizedBox(height: 10),
                descriptionLine(text: "expiration_date".translate(context)),
                const SizedBox(height: 10),
                CustomPickerWidget(
                  text: DateFormat("dd/MM/yyyy").format(selectedDate),
                  onPress: () => selectDate(),
                ),
                descriptionLine(text: "promotion".translate(context)),
                const SizedBox(height: 10),
                CustomTextInput(
                  controller: specialController,
                  hint: "100.000đ",
                  keyboardType: TextInputType.number,
                  title: "promotion".translate(context).toLowerCase(),
                ),
                const SizedBox(height: 10),
                descriptionLine(text: "voucher_content".translate(context)),
                const SizedBox(height: 10),
                CustomTextInput(
                  controller: contentController,
                  hint: "voucher_content".translate(context),
                  title: "voucher_content".translate(context).toLowerCase(),
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
