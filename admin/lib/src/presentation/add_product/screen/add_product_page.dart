import 'dart:io';

import 'package:coffee_admin/src/controls/extension/string_extension.dart';
import 'package:coffee_admin/src/presentation/login/widgets/custom_text_input.dart';
import 'package:coffee_admin/src/presentation/product/widgets/description_line.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_pick_image.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? image;

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "add_products".translate(context),
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
                      ? Image.asset("assets/tea.png", height: 150, width: 150)
                      : Image.file(image!, height: 150, width: 150),
                ),
                const SizedBox(height: 30),
                descriptionLine(text: "product_name".translate(context)),
                const SizedBox(height: 10),
                CustomTextInput(
                  controller: nameController,
                  hint: "product_name".translate(context),
                  title: "product_name".translate(context).toLowerCase(),
                ),
                const SizedBox(height: 10),
                descriptionLine(text: "product_price".translate(context)),
                const SizedBox(height: 10),
                CustomTextInput(
                  controller: priceController,
                  hint: "100.000đ",
                  title: "product_price".translate(context).toLowerCase(),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                descriptionLine(text: "product_description".translate(context)),
                const SizedBox(height: 10),
                CustomTextInput(
                  controller: descriptionController,
                  hint: "product_description".translate(context),
                  title: "product_description".translate(context).toLowerCase(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
