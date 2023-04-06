import 'dart:io';

import 'package:coffee_admin/src/core/function/loading_animation.dart';
import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:coffee_admin/src/data/models/topping.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/utils/constants/constants.dart';
import '../../add_product/widgets/bottom_pick_image.dart';
import '../../forgot_password/widgets/app_bar_general.dart';
import '../../login/widgets/custom_button.dart';
import '../../product/widgets/description_line.dart';
import '../../signup/widgets/custom_text_input.dart';
import '../bloc/add_topping_bloc.dart';
import '../bloc/add_topping_event.dart';
import '../bloc/add_topping_state.dart';

class AddToppingPage extends StatelessWidget {
  const AddToppingPage({Key? key, required this.onChange}) : super(key: key);

  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddToppingBloc(),
      child: Scaffold(
        appBar: const AppBarGeneral(elevation: 0, title: "Thêm Topping"),
        body: AddToppingView(onChange: onChange),
      ),
    );
  }
}

class AddToppingView extends StatefulWidget {
  const AddToppingView({Key? key, required this.onChange}) : super(key: key);

  final VoidCallback onChange;

  @override
  State<AddToppingView> createState() => _AddToppingViewState();
}

class _AddToppingViewState extends State<AddToppingView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? image;

  @override
  void initState() {
    nameController.addListener(() => checkEmpty());
    priceController.addListener(() => checkEmpty());
    descriptionController.addListener(() => checkEmpty());
    super.initState();
  }

  void checkEmpty() {
    if (nameController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        image != null) {
      context.read<AddToppingBloc>().add(SaveButtonEvent(true));
    } else {
      context.read<AddToppingBloc>().add(SaveButtonEvent(false));
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
    return BlocListener<AddToppingBloc, AddToppingState>(
      listener: (context, state) {
        if (state is AddToppingSuccessState) {
          Fluttertoast.showToast(msg: "Thêm sản phẩm thành công");
          widget.onChange();
          Navigator.pop(context);
          Navigator.pop(context);
        }
        if (state is AddToppingLoadingState) {
          loadingAnimation(context);
        }
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              toppingImage(),
              const SizedBox(height: 30),
              descriptionLine(text: "Tên Topping"),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: nameController,
                hint: "Tên Topping",
                title: "Tên Topping",
              ),
              const SizedBox(height: 10),
              descriptionLine(text: "Giá Topping"),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: priceController,
                hint: "100.000đ",
                title: "Giá Topping",
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                ],
              ),
              const SizedBox(height: 10),
              descriptionLine(text: "Mô tả"),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: descriptionController,
                hint: "Mô tả",
                title: "Mô tả",
              ),
              const SizedBox(height: 10),
              saveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget toppingImage() {
    return BlocBuilder<AddToppingBloc, AddToppingState>(
      buildWhen: (previous, current) => current is ChangeImageState,
      builder: (context, state) {
        checkEmpty();
        return InkWell(
          onTap: () => showMyBottomSheet(context, (image) {
            this.image = image;
            context
                .read<AddToppingBloc>()
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
    return BlocBuilder<AddToppingBloc, AddToppingState>(
      buildWhen: (previous, current) => current is SaveButtonState,
      builder: (context, state) {
        return customButton(
          text: "save".translate(context),
          isOnPress: state is SaveButtonState ? state.isContinue : false,
          onPress: () {
            if (_formKey.currentState!.validate()) {
              context.read<AddToppingBloc>().add(CreateToppingEvent(Topping(
                    toppingName: nameController.text,
                    description: descriptionController.text,
                    pricePerService: int.parse(priceController.text),
                  )));
            }
          },
        );
      },
    );
  }
}
