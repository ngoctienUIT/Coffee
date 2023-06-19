import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_admin/src/core/function/custom_toast.dart';
import 'package:coffee_admin/src/core/function/loading_animation.dart';
import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:coffee_admin/src/data/models/coupon.dart';
import 'package:coffee_admin/src/domain/repositories/coupon/coupon_response.dart';
import 'package:coffee_admin/src/presentation/add_coupon/bloc/add_coupon_event.dart';
import 'package:coffee_admin/src/presentation/view_order/widgets/item_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/services/bloc/service_bloc.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../data/models/preferences_model.dart';
import '../../add_product/widgets/bottom_pick_image.dart';
import '../../login/widgets/custom_button.dart';
import '../../order/widgets/item_loading.dart';
import '../../product/widgets/description_line.dart';
import '../../signup/widgets/custom_text_input.dart';
import '../bloc/add_coupon_bloc.dart';
import '../bloc/add_coupon_state.dart';
import '../widgets/custom_picker_widget.dart';

class AddCouponPage extends StatelessWidget {
  const AddCouponPage({Key? key, this.coupon, required this.onChange})
      : super(key: key);

  final VoidCallback onChange;
  final CouponResponse? coupon;

  @override
  Widget build(BuildContext context) {
    PreferencesModel preferencesModel =
        context.read<ServiceBloc>().preferencesModel;
    return BlocProvider(
      create: (context) => AddCouponBloc(preferencesModel),
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
        body: AddCouponView(coupon: coupon, onChange: onChange),
      ),
    );
  }
}

class AddCouponView extends StatefulWidget {
  const AddCouponView({Key? key, this.coupon, required this.onChange})
      : super(key: key);

  final CouponResponse? coupon;
  final VoidCallback onChange;

  @override
  State<AddCouponView> createState() => _AddCouponViewState();
}

class _AddCouponViewState extends State<AddCouponView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController couponCodeController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController minApplyController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController capAmountController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  File? image;
  String? imageNetWork;
  bool isRate = false;
  final Color selectedColor = AppColors.statusBarColor;
  final Color unselectedColor = AppColors.unselectedColor;

  @override
  void initState() {
    if (widget.coupon != null) {
      titleController.text = widget.coupon!.couponName;
      amountController.text = widget.coupon!.discountAmount.toString();
      rateController.text = widget.coupon!.discountRate.toString();
      contentController.text = widget.coupon!.content;
      capAmountController.text =
          widget.coupon!.discountRateCapAmount.toString();
      minApplyController.text =
          widget.coupon!.minimumOrderAmountCriterion.toString();
      imageNetWork = widget.coupon!.imageUrl;
      isRate = widget.coupon!.discountRate != null;
    }
    titleController.addListener(() => checkEmpty());
    amountController.addListener(() => checkEmpty());
    minApplyController.addListener(() => checkEmpty());
    contentController.addListener(() => checkEmpty());
    super.initState();
  }

  void checkEmpty() {
    if (titleController.text.isNotEmpty &&
        contentController.text.isNotEmpty &&
        minApplyController.text.isNotEmpty &&
        // couponCodeController.text.isNotEmpty &&
        (image != null || imageNetWork != null || widget.coupon != null) &&
        (amountController.text.isNotEmpty ||
            (rateController.text.isNotEmpty &&
                capAmountController.text.isNotEmpty))) {
      context.read<AddCouponBloc>().add(SaveButtonEvent(true));
    } else {
      context.read<AddCouponBloc>().add(SaveButtonEvent(false));
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    contentController.dispose();
    minApplyController.dispose();
    capAmountController.dispose();
    rateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddCouponBloc, AddCouponState>(
      listener: (context, state) {
        if (state is AddCouponSuccessState) {
          widget.onChange();
          if (widget.coupon == null) {
            customToast(
                context, "successfully_added_coupon".translate(context));
          } else {
            customToast(context, "update_successful".translate(context));
          }
          Navigator.pop(context);
          Navigator.pop(context);
        }
        if (state is AddCouponLoadingState) {
          loadingAnimation(context);
        }
        if (state is AddCouponErrorState) {
          customToast(context, state.status);
          Navigator.pop(context);
        }
        if (state is ChangeDateState ||
            state is ChangeTypeState ||
            state is ChangeImageState) {
          checkEmpty();
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
              descriptionLine(text: "coupon_code".translate(context)),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: couponCodeController,
                hint: "coupon_code".translate(context),
                title: "coupon_code".translate(context).toLowerCase(),
              ),
              const SizedBox(height: 10),
              descriptionLine(text: "expiration_date".translate(context)),
              const SizedBox(height: 10),
              orderDate(),
              const SizedBox(height: 10),
              typeCoupon(),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              descriptionLine(text: "minimum".translate(context)),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: minApplyController,
                hint: "100.000đ",
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                ],
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
    );
  }

  Widget typeCoupon() {
    return BlocBuilder<AddCouponBloc, AddCouponState>(
      buildWhen: (previous, current) => current is ChangeTypeState,
      builder: (context, state) {
        return Column(
          children: [
            descriptionLine(text: "coupon_type".translate(context)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    isRate = !isRate;
                    context.read<AddCouponBloc>().add(ChangeTypeEvent());
                  },
                  child: itemType(
                    "cash".translate(context),
                    isRate ? unselectedColor : selectedColor,
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    isRate = !isRate;
                    context.read<AddCouponBloc>().add(ChangeTypeEvent());
                  },
                  child: itemType(
                    "rate".translate(context),
                    isRate ? selectedColor : unselectedColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            isRate ? rateType() : amountType(),
          ],
        );
      },
    );
  }

  Widget rateType() {
    return Column(
      children: [
        descriptionLine(text: "rate".translate(context)),
        const SizedBox(height: 10),
        CustomTextInput(
          controller: rateController,
          hint: "10%",
          keyboardType: TextInputType.number,
          title: "promotion".translate(context).toLowerCase(),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z.]")),
          ],
        ),
        const SizedBox(height: 10),
        descriptionLine(text: "maximum".translate(context)),
        const SizedBox(height: 10),
        CustomTextInput(
          controller: capAmountController,
          hint: "100.000đ",
          keyboardType: TextInputType.number,
          title: "promotion".translate(context).toLowerCase(),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
          ],
        ),
      ],
    );
  }

  Widget amountType() {
    return Column(
      children: [
        descriptionLine(text: "promotion".translate(context)),
        const SizedBox(height: 10),
        CustomTextInput(
          controller: amountController,
          hint: "100.000đ",
          keyboardType: TextInputType.number,
          title: "promotion".translate(context).toLowerCase(),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
          ],
        ),
      ],
    );
  }

  Widget orderDate() {
    return BlocBuilder<AddCouponBloc, AddCouponState>(
      buildWhen: (previous, current) => current is ChangeDateState,
      builder: (context, state) {
        checkEmpty();
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
        checkEmpty();
        return InkWell(
          onTap: () => showMyBottomSheet(context, (image) {
            this.image = image;
            context
                .read<AddCouponBloc>()
                .add(ChangeImageEvent(image == null ? "" : image.path));
          }),
          child: image == null
              ? (imageNetWork == null
                  ? Image.asset(AppImages.imgAddImage, height: 150, width: 150)
                  : CachedNetworkImage(
                      height: 150,
                      width: 150,
                      imageUrl: imageNetWork!,
                      placeholder: (context, url) => itemLoading(150, 150, 0),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ))
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
            text: "save".translate(context),
            isOnPress: state is SaveButtonState ? state.isContinue : false,
            onPress: () {
              if (_formKey.currentState!.validate()) {
                if (isRate) {
                  double rate = double.parse(rateController.text);
                  if (rate > 1 || rate == 0) {
                    customToast(context, "invalid_rate".translate(context));
                    return;
                  }
                }
                if (widget.coupon == null) {
                  context.read<AddCouponBloc>().add(CreateCouponEvent(Coupon(
                        couponName: titleController.text,
                        couponCode: couponCodeController.text,
                        content: contentController.text,
                        dueDate: DateFormat("dd/MM/yyyy").format(selectedDate),
                        minimumOrderAmountCriterion:
                            int.parse(minApplyController.text),
                        discountRateCapAmount:
                            isRate ? int.parse(capAmountController.text) : null,
                        discountRate:
                            isRate ? double.parse(rateController.text) : null,
                        discountAmount:
                            isRate ? null : int.parse(amountController.text),
                      )));
                } else {
                  context.read<AddCouponBloc>().add(UpdateCouponEvent(Coupon(
                        couponName: titleController.text,
                        couponCode: couponCodeController.text,
                        content: contentController.text,
                        imageUrl: imageNetWork,
                        dueDate: DateFormat("dd/MM/yyyy").format(selectedDate),
                        minimumOrderAmountCriterion:
                            int.parse(minApplyController.text),
                        discountRateCapAmount:
                            isRate ? int.parse(capAmountController.text) : null,
                        discountRate:
                            isRate ? double.parse(rateController.text) : null,
                        discountAmount:
                            isRate ? null : int.parse(amountController.text),
                        id: widget.coupon!.id,
                      )));
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
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      if (mounted) context.read<AddCouponBloc>().add(ChangeDateEvent());
      selectedDate = picked;
    }
  }
}
