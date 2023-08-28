import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_admin/injection.dart';
import 'package:coffee_admin/src/core/function/loading_animation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:coffee_admin/src/data/models/topping.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/utils/constants/constants.dart';
import '../../add_product/widgets/bottom_pick_image.dart';
import '../../forgot_password/widgets/app_bar_general.dart';
import '../../login/widgets/custom_button.dart';
import '../../order/widgets/item_loading.dart';
import '../../product/widgets/description_line.dart';
import '../../signup/widgets/custom_text_input.dart';
import '../bloc/add_topping_bloc.dart';
import '../bloc/add_topping_event.dart';
import '../bloc/add_topping_state.dart';

class AddToppingPage extends StatelessWidget {
  const AddToppingPage({Key? key, required this.onChange, this.topping})
      : super(key: key);

  final VoidCallback onChange;
  final Topping? topping;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddToppingBloc>(
      create: (context) => getIt<AddToppingBloc>(),
      child: Scaffold(
        appBar: AppBarGeneral(
            elevation: 0, title: AppLocalizations.of(context)!.addTopping),
        body: AddToppingView(onChange: onChange, topping: topping),
      ),
    );
  }
}

class AddToppingView extends StatefulWidget {
  const AddToppingView({Key? key, required this.onChange, this.topping})
      : super(key: key);

  final VoidCallback onChange;
  final Topping? topping;

  @override
  State<AddToppingView> createState() => _AddToppingViewState();
}

class _AddToppingViewState extends State<AddToppingView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? image;
  String? imageNetwork;

  @override
  void initState() {
    if (widget.topping != null) {
      nameController.text = widget.topping!.toppingName;
      priceController.text = widget.topping!.pricePerService.toString();
      descriptionController.text = widget.topping!.description;
      imageNetwork = widget.topping!.imageUrl;
    }
    nameController.addListener(() => checkEmpty());
    priceController.addListener(() => checkEmpty());
    descriptionController.addListener(() => checkEmpty());
    super.initState();
  }

  void checkEmpty() {
    if (nameController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        (image != null || imageNetwork != null)) {
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
          if (widget.topping == null) {
            customToast(context,
                AppLocalizations.of(context)!.successfullyAddedTopping);
          } else {
            customToast(
                context, AppLocalizations.of(context)!.updateSuccessful);
          }
          widget.onChange();
          Navigator.pop(context);
          Navigator.pop(context);
        }
        if (state is AddToppingLoadingState) {
          loadingAnimation(context);
        }
        if (state is AddToppingErrorState) {
          customToast(context, state.status);
          Navigator.pop(context);
        }
        if (state is ChangeImageState) {
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
              toppingImage(),
              const SizedBox(height: 30),
              descriptionLine(text: AppLocalizations.of(context)!.nameTopping),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: nameController,
                hint: AppLocalizations.of(context)!.nameTopping,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.nameTopping}";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              descriptionLine(text: AppLocalizations.of(context)!.toppingPrice),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: priceController,
                hint: "100.000đ",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.toppingPrice}";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                ],
              ),
              const SizedBox(height: 10),
              descriptionLine(text: AppLocalizations.of(context)!.description),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: descriptionController,
                hint: AppLocalizations.of(context)!.description,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.description}";
                  }
                  return null;
                },
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
                .add(ChangeImageEvent(image?.path ?? ""));
          }),
          child: image == null
              ? (imageNetwork != null
                  ? CachedNetworkImage(
                      height: 150,
                      width: 150,
                      imageUrl: imageNetwork!,
                      placeholder: (context, url) => itemLoading(150, 150, 0),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )
                  : Image.asset(AppImages.imgAddImage, height: 150, width: 150))
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
          text: AppLocalizations.of(context)!.save,
          isOnPress: state is SaveButtonState ? state.isContinue : false,
          onPress: () {
            if (_formKey.currentState!.validate()) {
              if (widget.topping == null) {
                context.read<AddToppingBloc>().add(CreateToppingEvent(Topping(
                      toppingName: nameController.text,
                      description: descriptionController.text,
                      pricePerService: int.parse(priceController.text),
                    )));
              } else {
                context.read<AddToppingBloc>().add(UpdateToppingEvent(Topping(
                      toppingName: nameController.text,
                      description: descriptionController.text,
                      pricePerService: int.parse(priceController.text),
                      imageUrl: imageNetwork,
                      toppingId: widget.topping!.toppingId,
                    )));
              }
            }
          },
        );
      },
    );
  }
}
