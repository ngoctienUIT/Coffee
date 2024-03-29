import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_admin/injection.dart';
import 'package:coffee_admin/src/core/function/custom_toast.dart';
import 'package:coffee_admin/src/core/function/loading_animation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:coffee_admin/src/data/models/coupon.dart';
import 'package:coffee_admin/src/data/remote/response/coupon/coupon_response.dart';
import 'package:coffee_admin/src/presentation/add_coupon/bloc/add_coupon_event.dart';
import 'package:coffee_admin/src/presentation/view_order/widgets/item_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/constants/constants.dart';
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
    return BlocProvider<AddCouponBloc>(
      create: (context) => getIt<AddCouponBloc>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            AppLocalizations.of(context)!.addVoucher,
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
                context, AppLocalizations.of(context)!.successfullyAddedCoupon);
          } else {
            customToast(
                context, AppLocalizations.of(context)!.updateSuccessful);
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
              descriptionLine(text: AppLocalizations.of(context)!.voucherTitle),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: titleController,
                hint: AppLocalizations.of(context)!.voucherTitle,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.title.toLowerCase()}";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              descriptionLine(text: AppLocalizations.of(context)!.couponCode),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: couponCodeController,
                hint: AppLocalizations.of(context)!.couponCode,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.couponCode.toUpperCase()}";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              descriptionLine(
                  text: AppLocalizations.of(context)!.expirationDate),
              const SizedBox(height: 10),
              orderDate(),
              const SizedBox(height: 10),
              typeCoupon(),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              descriptionLine(text: AppLocalizations.of(context)!.minimum),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: minApplyController,
                hint: "100.000đ",
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return "${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.promotion}";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              descriptionLine(
                  text: AppLocalizations.of(context)!.voucherContent),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: contentController,
                hint: AppLocalizations.of(context)!.voucherContent,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.voucherContent.toUpperCase()}";
                  }
                  return null;
                },
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
            descriptionLine(text: AppLocalizations.of(context)!.couponType),
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
                    AppLocalizations.of(context)!.cash,
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
                    AppLocalizations.of(context)!.rate,
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
        descriptionLine(text: AppLocalizations.of(context)!.rate),
        const SizedBox(height: 10),
        CustomTextInput(
          controller: rateController,
          hint: "10%",
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) {
              return "${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.promotion.toLowerCase()}";
            }
            return null;
          },
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z.]")),
          ],
        ),
        const SizedBox(height: 10),
        descriptionLine(text: AppLocalizations.of(context)!.maximum),
        const SizedBox(height: 10),
        CustomTextInput(
          controller: capAmountController,
          hint: "100.000đ",
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) {
              return "${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.promotion.toLowerCase()}";
            }
            return null;
          },
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
        descriptionLine(text: AppLocalizations.of(context)!.promotion),
        const SizedBox(height: 10),
        CustomTextInput(
          controller: amountController,
          hint: "100.000đ",
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) {
              return "${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.promotion.toLowerCase()}";
            }
            return null;
          },
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
                .add(ChangeImageEvent(image?.path ?? ""));
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
            text: AppLocalizations.of(context)!.save,
            isOnPress: state is SaveButtonState ? state.isContinue : false,
            onPress: () {
              if (_formKey.currentState!.validate()) {
                if (isRate) {
                  double rate = double.parse(rateController.text);
                  if (rate > 1 || rate == 0) {
                    customToast(
                        context, AppLocalizations.of(context)!.invalidRate);
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
