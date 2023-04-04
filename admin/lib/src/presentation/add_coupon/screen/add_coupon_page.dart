import 'dart:io';

import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:coffee_admin/src/data/models/coupon.dart';
import 'package:coffee_admin/src/presentation/add_coupon/bloc/add_coupon_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../add_product/widgets/bottom_pick_image.dart';
import '../../login/widgets/custom_button.dart';
import '../../product/widgets/description_line.dart';
import '../../signup/widgets/custom_text_input.dart';
import '../bloc/add_coupon_bloc.dart';
import '../bloc/add_coupon_state.dart';
import '../widgets/custom_picker_widget.dart';

class AddCouponPage extends StatelessWidget {
  const AddCouponPage({Key? key, this.coupon}) : super(key: key);

  final Coupon? coupon;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCouponBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "add_voucher".translate(context),
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const AddCouponView(),
      ),
    );
  }
}

class AddCouponView extends StatefulWidget {
  const AddCouponView({Key? key, this.coupon}) : super(key: key);

  final Coupon? coupon;

  @override
  State<AddCouponView> createState() => _AddCouponViewState();
}

class _AddCouponViewState extends State<AddCouponView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController specialController = TextEditingController();
  TextEditingController minApplyController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  File? image;
  late Coupon coupon;

  @override
  void initState() {
    if (widget.coupon != null) {
      coupon = widget.coupon!.copyWith();
      titleController.text = coupon.couponName;
      specialController.text = coupon.discountRateCapAmount.toString();
      minApplyController.text = coupon.minimumOrderAmountCriterion.toString();
      contentController.text = coupon.content;
    }
    titleController.addListener(() => checkEmpty());
    specialController.addListener(() => checkEmpty());
    minApplyController.addListener(() => checkEmpty());
    contentController.addListener(() => checkEmpty());
    super.initState();
  }

  void checkEmpty() {
    if (titleController.text.isNotEmpty &&
        specialController.text.isNotEmpty &&
        contentController.text.isNotEmpty &&
        minApplyController.text.isNotEmpty) {
      context.read<AddCouponBloc>().add(SaveButtonEvent(true));
    } else {
      context.read<AddCouponBloc>().add(SaveButtonEvent(false));
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    specialController.dispose();
    contentController.dispose();
    minApplyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddCouponBloc, AddCouponState>(
      listener: (context, state) {
        if (state is AddCouponSuccessState) {
          Fluttertoast.showToast(msg: "Thêm coupon thành công");
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
                orderImage(),
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
                orderDate(),
                const SizedBox(height: 10),
                descriptionLine(text: "promotion".translate(context)),
                const SizedBox(height: 10),
                CustomTextInput(
                  controller: specialController,
                  hint: "100.000đ",
                  keyboardType: TextInputType.number,
                  title: "promotion".translate(context).toLowerCase(),
                ),
                const SizedBox(height: 10),
                descriptionLine(text: "Min"),
                const SizedBox(height: 10),
                CustomTextInput(
                  controller: minApplyController,
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
                const SizedBox(height: 20),
                saveButton(),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget orderDate() {
    return BlocBuilder<AddCouponBloc, AddCouponState>(
      buildWhen: (previous, current) => current is ChangeDateState,
      builder: (context, state) {
        return CustomPickerWidget(
          text: DateFormat("dd/MM/yyyy").format(selectedDate),
          onPress: () => selectDate(),
        );
      },
    );
  }

  Widget orderImage() {
    return BlocBuilder<AddCouponBloc, AddCouponState>(
      buildWhen: (previous, current) => current is ChangeImageState,
      builder: (context, state) {
        return InkWell(
          onTap: () => showMyBottomSheet(context, (image) {
            this.image = image;
            context.read<AddCouponBloc>().add(ChangeImageEvent());
          }),
          child: image == null
              ? Image.asset("assets/tea.png", height: 150, width: 150)
              : Image.file(image!, height: 150, width: 150),
        );
      },
    );
  }

  Widget saveButton() {
    return BlocBuilder<AddCouponBloc, AddCouponState>(
      buildWhen: (previous, current) => current is SaveButtonState,
      builder: (context, state) {
        return customButton(
            text: "Lưu",
            isOnPress: state is SaveButtonState ? state.isContinue : false,
            onPress: () {
              if (_formKey.currentState!.validate()) {
                if (widget.coupon == null) {
                  context.read<AddCouponBloc>().add(CreateCouponEvent(Coupon(
                      couponName: titleController.text,
                      couponCode: "couponCode",
                      content: contentController.text,
                      imageUrl: "imageUrl",
                      dueDate: DateFormat("dd/MM/yyyy").format(selectedDate),
                      discountRateCapAmount: int.parse(specialController.text),
                      minimumOrderAmountCriterion:
                          int.parse(minApplyController.text))));
                } else {
                  context
                      .read<AddCouponBloc>()
                      .add(UpdateCouponEvent(coupon.copyWith()));
                }
              }
            });
      },
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
      context.read<AddCouponBloc>().add(ChangeDateEvent());
      selectedDate = picked;
    }
  }
}
