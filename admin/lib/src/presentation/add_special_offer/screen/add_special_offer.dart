import 'dart:io';

import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../add_coupon/widgets/custom_picker_widget.dart';
import '../../add_product/widgets/bottom_pick_image.dart';
import '../../product/widgets/description_line.dart';
import '../../signup/widgets/custom_text_input.dart';

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
        title: Text(
          "add_promotion".translate(context),
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
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
                descriptionLine(text: "promotion_title".translate(context)),
                const SizedBox(height: 10),
                CustomTextInput(
                  controller: titleController,
                  hint: "promotion_title".translate(context),
                  title: "title".translate(context).toLowerCase(),
                ),
                const SizedBox(height: 10),
                descriptionLine(text: "start_day".translate(context)),
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
                descriptionLine(text: "finish_date".translate(context)),
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
                descriptionLine(text: "promotional_content".translate(context)),
                const SizedBox(height: 10),
                CustomTextInput(
                  controller: contentController,
                  hint: "promotion_description".translate(context),
                  title:
                      "promotion_description".translate(context).toLowerCase(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
