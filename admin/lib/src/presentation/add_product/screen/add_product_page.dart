import 'dart:io';

import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:coffee_admin/src/data/models/product.dart';
import 'package:coffee_admin/src/domain/repositories/product_catalogues/product_catalogues_response.dart';
import 'package:coffee_admin/src/presentation/add_product/bloc/add_product_bloc.dart';
import 'package:coffee_admin/src/presentation/add_product/bloc/add_product_event.dart';
import 'package:coffee_admin/src/presentation/add_product/bloc/add_product_state.dart';
import 'package:coffee_admin/src/presentation/login/widgets/custom_button.dart';
import 'package:coffee_admin/src/presentation/product/widgets/description_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../product_catalogues/screen/product_catalogues_page.dart';
import '../../profile/widgets/custom_picker_widget.dart';
import '../../signup/widgets/custom_text_input.dart';
import '../widgets/bottom_pick_image.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({Key? key, this.product}) : super(key: key);

  final Product? product;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductBloc(),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "add_products".translate(context),
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: AddProductView(product: product),
      ),
    );
  }
}

class AddProductView extends StatefulWidget {
  const AddProductView({Key? key, this.product}) : super(key: key);

  final Product? product;

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController sController = TextEditingController();
  TextEditingController mController = TextEditingController();
  TextEditingController lController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? image;
  late Product product;
  ProductCataloguesResponse? catalogues;

  @override
  void initState() {
    if (widget.product != null) {
      product = widget.product!.copyWith();
      nameController.text = product.name;
      priceController.text = product.price.toString();
      descriptionController.text = product.description!;
    }
    nameController.addListener(() => checkEmpty());
    priceController.addListener(() => checkEmpty());
    descriptionController.addListener(() => checkEmpty());
    sController.addListener(() => checkEmpty());
    mController.addListener(() => checkEmpty());
    lController.addListener(() => checkEmpty());
    super.initState();
  }

  void checkEmpty() {
    if (nameController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        sController.text.isNotEmpty &&
        mController.text.isNotEmpty &&
        lController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        image != null &&
        catalogues != null) {
      context.read<AddProductBloc>().add(SaveButtonEvent(true));
    } else {
      context.read<AddProductBloc>().add(SaveButtonEvent(false));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddProductBloc, AddProductState>(
      listener: (context, state) {
        if (state is AddProductSuccessState) {
          Fluttertoast.showToast(msg: "Thêm sản phẩm thành công");
          Future.delayed(
            const Duration(seconds: 3),
            () => Navigator.pop(context),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 10),
                productImage(),
                const SizedBox(height: 30),
                descriptionLine(text: "Loại sản phẩm"),
                const SizedBox(height: 10),
                productCatalogue(),
                const SizedBox(height: 10),
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
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                  ],
                ),
                const SizedBox(height: 10),
                descriptionLine(text: "S"),
                const SizedBox(height: 10),
                CustomTextInput(
                  controller: sController,
                  hint: "100.000đ",
                  title: "S",
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                  ],
                ),
                const SizedBox(height: 10),
                descriptionLine(text: "M"),
                const SizedBox(height: 10),
                CustomTextInput(
                  controller: mController,
                  hint: "100.000đ",
                  title: "M",
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                  ],
                ),
                const SizedBox(height: 10),
                descriptionLine(text: "L"),
                const SizedBox(height: 10),
                CustomTextInput(
                  controller: lController,
                  hint: "100.000đ",
                  title: "L",
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                  ],
                ),
                const SizedBox(height: 10),
                descriptionLine(text: "product_description".translate(context)),
                const SizedBox(height: 10),
                CustomTextInput(
                  controller: descriptionController,
                  hint: "product_description".translate(context),
                  title: "product_description".translate(context).toLowerCase(),
                ),
                const SizedBox(height: 10),
                saveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget productCatalogue() {
    return BlocBuilder<AddProductBloc, AddProductState>(
      buildWhen: (previous, current) => current is ChangeCatalogueState,
      builder: (context, state) {
        checkEmpty();
        return CustomPickerWidget(
          checkEdit: true,
          text: catalogues == null ? 'Loại sản phẩm' : catalogues!.name,
          onPress: () {
            Navigator.of(context).push(
              createRoute(
                  screen: ProductCataloguesPage(
                    onPick: (catalogue) {
                      catalogues = catalogue;
                      context
                          .read<AddProductBloc>()
                          .add(ChangeCatalogueEvent(catalogue.id));
                    },
                  ),
                  begin: const Offset(1, 0)),
            );
          },
        );
      },
    );
  }

  Widget productImage() {
    return BlocBuilder<AddProductBloc, AddProductState>(
      buildWhen: (previous, current) => current is ChangeImageState,
      builder: (context, state) {
        checkEmpty();
        return InkWell(
          onTap: () => showMyBottomSheet(context, (image) {
            this.image = image;
            context
                .read<AddProductBloc>()
                .add(ChangeImageEvent(image == null ? "" : image.path));
          }),
          child: image == null
              ? Image.asset(AppImages.imgAddImage, height: 150, width: 150)
              : Image.file(image!, height: 150, width: 150),
        );
      },
    );
  }

  Widget saveButton() {
    return BlocBuilder<AddProductBloc, AddProductState>(
      buildWhen: (previous, current) => current is SaveButtonState,
      builder: (context, state) {
        return customButton(
          text: "save".translate(context),
          isOnPress: state is SaveButtonState ? state.isContinue : false,
          onPress: () {
            if (_formKey.currentState!.validate()) {
              if (widget.product == null) {
                context.read<AddProductBloc>().add(CreateProductEvent(Product(
                      name: nameController.text,
                      price: int.parse(priceController.text),
                      description: descriptionController.text,
                      M: int.parse(mController.text),
                      L: int.parse(lController.text),
                      S: int.parse(sController.text),
                    )));
              } else {
                context
                    .read<AddProductBloc>()
                    .add(UpdateProductEvent(product.copyWith()));
              }
            }
          },
        );
      },
    );
  }
}
