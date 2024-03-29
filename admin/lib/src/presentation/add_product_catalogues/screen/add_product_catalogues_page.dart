import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_admin/injection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/function/loading_animation.dart';
import '../../../core/utils/constants/app_images.dart';
import '../../../data/models/product_catalogues.dart';
import '../../add_product/widgets/bottom_pick_image.dart';
import '../../forgot_password/widgets/app_bar_general.dart';
import '../../login/widgets/custom_button.dart';
import '../../order/widgets/item_loading.dart';
import '../../product/widgets/description_line.dart';
import '../../signup/widgets/custom_text_input.dart';
import '../bloc/add_product_catalogues_bloc.dart';
import '../bloc/add_product_catalogues_event.dart';
import '../bloc/add_product_catalogues_state.dart';

class AddProductCataloguesPage extends StatelessWidget {
  const AddProductCataloguesPage(
      {Key? key, required this.onChange, this.productCatalogues})
      : super(key: key);

  final VoidCallback onChange;
  final ProductCatalogues? productCatalogues;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddProductCataloguesBloc>(),
      child: Scaffold(
        appBar: AppBarGeneral(
          elevation: 0,
          title: AppLocalizations.of(context)!.addProductCatalog,
        ),
        body: AddProductCataloguesView(
          onChange: onChange,
          productCatalogues: productCatalogues,
        ),
      ),
    );
  }
}

class AddProductCataloguesView extends StatefulWidget {
  const AddProductCataloguesView(
      {Key? key, required this.onChange, this.productCatalogues})
      : super(key: key);

  final VoidCallback onChange;
  final ProductCatalogues? productCatalogues;

  @override
  State<AddProductCataloguesView> createState() =>
      _AddProductCataloguesViewState();
}

class _AddProductCataloguesViewState extends State<AddProductCataloguesView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? image;
  String? imageNetwork;

  @override
  void initState() {
    if (widget.productCatalogues != null) {
      nameController.text = widget.productCatalogues!.name;
      descriptionController.text = widget.productCatalogues!.description;
      imageNetwork = widget.productCatalogues!.image;
    }
    nameController.addListener(() => checkEmpty());
    descriptionController.addListener(() => checkEmpty());
    super.initState();
  }

  void checkEmpty() {
    if (nameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        (image != null || imageNetwork!.isNotEmpty)) {
      context.read<AddProductCataloguesBloc>().add(SaveButtonEvent(true));
    } else {
      context.read<AddProductCataloguesBloc>().add(SaveButtonEvent(false));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddProductCataloguesBloc, AddProductCataloguesState>(
      listener: (context, state) {
        if (state is AddProductCataloguesSuccessState) {
          if (widget.productCatalogues == null) {
            customToast(context,
                AppLocalizations.of(context)!.addSuccessfulProductCategories);
          } else {
            customToast(
                context, AppLocalizations.of(context)!.updateSuccessful);
          }
          widget.onChange();
          Navigator.pop(context);
          Navigator.pop(context);
        }
        if (state is AddProductCataloguesLoadingState) {
          loadingAnimation(context);
        }
        if (state is AddProductCataloguesErrorState) {
          Navigator.pop(context);
          customToast(context, state.status);
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
              productCataloguesImage(),
              const SizedBox(height: 30),
              descriptionLine(
                  text: AppLocalizations.of(context)!.productCategoryName),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: nameController,
                hint: AppLocalizations.of(context)!.productCategoryName,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.productCategoryName}";
                  }
                  return null;
                },
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

  Widget productCataloguesImage() {
    return BlocBuilder<AddProductCataloguesBloc, AddProductCataloguesState>(
      buildWhen: (previous, current) => current is ChangeImageState,
      builder: (context, state) {
        checkEmpty();
        return InkWell(
          onTap: () => showMyBottomSheet(context, (image) {
            this.image = image;
            context
                .read<AddProductCataloguesBloc>()
                .add(ChangeImageEvent(image?.path ?? ""));
          }),
          child: (image == null
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
              : Image.file(image!, height: 150, width: 150)),
        );
      },
    );
  }

  Widget saveButton() {
    return BlocBuilder<AddProductCataloguesBloc, AddProductCataloguesState>(
      buildWhen: (previous, current) => current is SaveButtonState,
      builder: (context, state) {
        return customButton(
          text: AppLocalizations.of(context)!.save,
          isOnPress: state is SaveButtonState ? state.isContinue : false,
          onPress: () {
            if (_formKey.currentState!.validate()) {
              if (widget.productCatalogues == null) {
                context
                    .read<AddProductCataloguesBloc>()
                    .add(CreateProductCataloguesEvent(ProductCatalogues(
                      name: nameController.text,
                      description: descriptionController.text,
                    )));
              } else {
                context
                    .read<AddProductCataloguesBloc>()
                    .add(UpdateProductCataloguesEvent(ProductCatalogues(
                      name: nameController.text,
                      description: descriptionController.text,
                      image: widget.productCatalogues!.image,
                      id: widget.productCatalogues!.id,
                    )));
              }
            }
          },
        );
      },
    );
  }
}
