import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_admin/injection.dart';
import 'package:coffee_admin/src/core/function/loading_animation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:coffee_admin/src/data/models/product.dart';
import 'package:coffee_admin/src/data/models/topping.dart';
import 'package:coffee_admin/src/data/remote/response/product_catalogues/product_catalogues_response.dart';
import 'package:coffee_admin/src/presentation/add_product/bloc/add_product_bloc.dart';
import 'package:coffee_admin/src/presentation/add_product/bloc/add_product_event.dart';
import 'package:coffee_admin/src/presentation/add_product/bloc/add_product_state.dart';
import 'package:coffee_admin/src/presentation/login/widgets/custom_button.dart';
import 'package:coffee_admin/src/presentation/product/widgets/description_line.dart';
import 'package:coffee_admin/src/presentation/tag/screen/tag_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../data/models/tag.dart';
import '../../order/widgets/item_loading.dart';
import '../../product_catalogues/screen/product_catalogues_page.dart';
import '../../profile/widgets/custom_picker_widget.dart';
import '../../signup/widgets/custom_text_input.dart';
import '../../topping/screen/topping_page.dart';
import '../widgets/bottom_pick_image.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({
    Key? key,
    this.product,
    required this.onChange,
    this.productCatalogues,
  }) : super(key: key);

  final Product? product;
  final VoidCallback onChange;
  final ProductCataloguesResponse? productCatalogues;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddProductBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            AppLocalizations.of(context)!.addProducts,
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: AddProductView(
          product: product,
          onChange: onChange,
          productCatalogues: productCatalogues,
        ),
      ),
    );
  }
}

class AddProductView extends StatefulWidget {
  const AddProductView(
      {Key? key, this.product, required this.onChange, this.productCatalogues})
      : super(key: key);

  final Product? product;
  final VoidCallback onChange;
  final ProductCataloguesResponse? productCatalogues;

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
  String? imageNetwork;
  List<Topping> listTopping = [];
  List<Tag> listTag = [];
  ProductCataloguesResponse? catalogues;

  @override
  void initState() {
    if (widget.product != null) {
      catalogues = widget.productCatalogues;
      nameController.text = widget.product!.name;
      priceController.text = widget.product!.price.toString();
      sController.text = widget.product!.S.toString();
      mController.text = widget.product!.M.toString();
      lController.text = widget.product!.L.toString();
      imageNetwork = widget.product!.image;
      descriptionController.text = widget.product!.description!;
      listTopping = widget.product!.toppingOptions ?? [];
      listTag = widget.product!.tags ?? [];
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
        (image != null || widget.product != null) &&
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
          widget.onChange();
          if (widget.product == null) {
            customToast(
                context, AppLocalizations.of(context)!.addSuccessfulProducts);
          } else {
            customToast(
                context, AppLocalizations.of(context)!.updateSuccessful);
          }
          Navigator.pop(context);
          Navigator.pop(context);
        }
        if (state is AddProductLoadingState) {
          loadingAnimation(context);
        }
        if (state is AddProductErrorState) {
          Navigator.pop(context);
          customToast(context, state.status);
        }
        if (state is ChangeCatalogueState ||
            state is ChangeTagState ||
            state is ChangeToppingState ||
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
              productImage(),
              const SizedBox(height: 30),
              descriptionLine(
                  text: AppLocalizations.of(context)!.productCatalogues),
              const SizedBox(height: 10),
              productCatalogue(),
              const SizedBox(height: 10),
              descriptionLine(text: AppLocalizations.of(context)!.productName),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: nameController,
                hint: AppLocalizations.of(context)!.productName,
                title: AppLocalizations.of(context)!.productName.toLowerCase(),
              ),
              const SizedBox(height: 10),
              descriptionLine(text: AppLocalizations.of(context)!.productPrice),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: priceController,
                hint: "100.000đ",
                title: AppLocalizations.of(context)!.productPrice.toLowerCase(),
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
              descriptionLine(
                  text: AppLocalizations.of(context)!.productDescription),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: descriptionController,
                hint: AppLocalizations.of(context)!.productDescription,
                title: AppLocalizations.of(context)!
                    .productDescription
                    .toLowerCase(),
              ),
              const SizedBox(height: 10),
              addTopping(),
              const SizedBox(height: 10),
              addTag(),
              const SizedBox(height: 10),
              saveButton(),
            ],
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
          text: catalogues == null
              ? AppLocalizations.of(context)!.productCatalogues
              : catalogues!.name,
          onPress: () {
            Navigator.of(context).push(
              createRoute(
                  screen: ProductCataloguesPage(
                    id: catalogues != null ? catalogues!.id : null,
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
              ? (imageNetwork == null
                  ? Image.asset(AppImages.imgAddImage, height: 150, width: 150)
                  : CachedNetworkImage(
                      height: 150,
                      width: 150,
                      imageUrl: imageNetwork!,
                      placeholder: (context, url) => itemLoading(150, 150, 0),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ))
              : Image.file(image!, height: 150, width: 150),
        );
      },
    );
  }

  Widget addTopping() {
    return Column(
      children: [
        Row(
          children: [
            descriptionLine(text: AppLocalizations.of(context)!.addTopping),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(createRoute(
                  screen: ToppingPage(
                    listTopping: listTopping.map((e) => e.toppingId!).toList(),
                    onPick: (list) {
                      listTopping = list;
                      context.read<AddProductBloc>().add(ChangeToppingEvent());
                    },
                  ),
                  begin: const Offset(0, 1),
                ));
              },
              child: Text(AppLocalizations.of(context)!.add),
            )
          ],
        ),
        BlocBuilder<AddProductBloc, AddProductState>(
          buildWhen: (previous, current) => current is ChangeToppingState,
          builder: (context, state) {
            return listTopping.isEmpty
                ? Text(
                    AppLocalizations.of(context)!.noToppings,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.statusBarColor,
                    ),
                  )
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: listTopping.length,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Text(
                              listTopping[index].toppingName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.statusBarColor,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                listTopping.removeAt(index);
                                context
                                    .read<AddProductBloc>()
                                    .add(ChangeToppingEvent());
                              },
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(90),
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                  size: 15,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
          },
        )
      ],
    );
  }

  Widget addTag() {
    return Column(
      children: [
        Row(
          children: [
            descriptionLine(text: AppLocalizations.of(context)!.addTags),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(createRoute(
                  screen: TagPage(
                    listTag: listTag.map((e) => e.tagId!).toList(),
                    onPick: (list) {
                      listTag = list;
                      context.read<AddProductBloc>().add(ChangeTagEvent());
                    },
                  ),
                  begin: const Offset(0, 1),
                ));
              },
              child: Text(AppLocalizations.of(context)!.add),
            )
          ],
        ),
        BlocBuilder<AddProductBloc, AddProductState>(
          buildWhen: (previous, current) => current is ChangeTagState,
          builder: (context, state) {
            return listTag.isEmpty
                ? Text(
                    AppLocalizations.of(context)!.noTags,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.statusBarColor,
                    ),
                  )
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: listTag.length,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemBuilder: (context, index) {
                      String color =
                          "FF${listTag[index].tagColorCode!.split("#").last}";
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(int.parse(color, radix: 16)),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Row(
                            children: [
                              Text(
                                "${listTag[index].tagName!} - ${listTag[index].tagColorCode!}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  listTag.removeAt(index);
                                  context
                                      .read<AddProductBloc>()
                                      .add(ChangeTagEvent());
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(90),
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.grey,
                                    size: 15,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
          },
        )
      ],
    );
  }

  Widget saveButton() {
    return BlocBuilder<AddProductBloc, AddProductState>(
      buildWhen: (previous, current) => current is SaveButtonState,
      builder: (context, state) {
        return customButton(
          text: AppLocalizations.of(context)!.save,
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
                      toppingOptions: listTopping,
                      tags: listTag,
                    )));
              } else {
                context.read<AddProductBloc>().add(UpdateProductEvent(Product(
                      name: nameController.text,
                      price: int.parse(priceController.text),
                      description: descriptionController.text,
                      M: int.parse(mController.text),
                      L: int.parse(lController.text),
                      S: int.parse(sController.text),
                      image: widget.product!.image,
                      toppingOptions: listTopping,
                      id: widget.product!.id,
                      tags: listTag,
                    )));
              }
            }
          },
        );
      },
    );
  }
}
