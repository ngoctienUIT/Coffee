import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_admin/injection.dart';
import 'package:coffee_admin/src/core/function/loading_animation.dart';
import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:coffee_admin/src/core/utils/extensions/time_of_date_extension.dart';
import 'package:coffee_admin/src/data/local/entity/store_entity.dart';
import 'package:coffee_admin/src/data/models/address.dart';
import 'package:coffee_admin/src/data/models/store.dart';
import 'package:coffee_admin/src/presentation/add_store/widgets/district_dropdown.dart';
import 'package:coffee_admin/src/presentation/add_store/widgets/province_dropdown.dart';
import 'package:coffee_admin/src/presentation/add_store/widgets/ward_dropdown.dart';
import 'package:coffee_admin/src/presentation/forgot_password/widgets/app_bar_general.dart';
import 'package:dvhcvn/dvhcvn.dart' as dvhcvn;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../core/utils/enum/enums.dart';
import '../../add_product/widgets/bottom_pick_image.dart';
import '../../login/widgets/custom_button.dart';
import '../../order/widgets/item_loading.dart';
import '../../product/widgets/description_line.dart';
import '../../profile/widgets/custom_picker_widget.dart';
import '../../signup/widgets/custom_text_input.dart';
import '../bloc/add_store_bloc.dart';
import '../bloc/add_store_event.dart';
import '../bloc/add_store_state.dart';
import '../widgets/country_dropdown.dart';

class AddStorePage extends StatelessWidget {
  const AddStorePage({Key? key, this.store, required this.onChange})
      : super(key: key);

  final VoidCallback onChange;
  final StoreEntity? store;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddStoreBloc>(),
      child: Scaffold(
        appBar: AppBarGeneral(
            elevation: 0, title: AppLocalizations.of(context)!.addStores),
        body: AddStoreView(store: store, onChange: onChange),
      ),
    );
  }
}

class AddStoreView extends StatefulWidget {
  const AddStoreView({Key? key, this.store, required this.onChange})
      : super(key: key);

  final VoidCallback onChange;
  final StoreEntity? store;

  @override
  State<AddStoreView> createState() => _AddStoreViewState();
}

class _AddStoreViewState extends State<AddStoreView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? image;
  AddressAPI addressAPI = AddressAPI();
  TimeOfDay? open;
  TimeOfDay? close;

  @override
  void initState() {
    if (widget.store != null) {
      nameController.text = widget.store!.storeName!;
      phoneController.text = widget.store!.hotlineNumber!;
      addressController.text = widget.store!.address1!;
      try {
        addressAPI.province = dvhcvn.findLevel1ByName(widget.store!.address4!);
        addressAPI.district = dvhcvn
            .findLevel1ByName(widget.store!.address4!)!
            .findLevel2ByName(widget.store!.address3!);
        addressAPI.ward = dvhcvn
            .findLevel1ByName(widget.store!.address4!)!
            .findLevel2ByName(widget.store!.address3!)!
            .findLevel3ByName(widget.store!.address2!);
      } catch (e) {
        print(e);
      }
      open = widget.store!.openingHour.toTime();
      close = widget.store!.closingHour.toTime();
    }
    nameController.addListener(() => checkEmpty());
    phoneController.addListener(() => checkEmpty());
    addressController.addListener(() => checkEmpty());
    checkEmpty();
    super.initState();
  }

  void checkEmpty() {
    if (nameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        (image != null || widget.store != null) &&
        close != null &&
        open != null &&
        !addressAPI.checkNull()) {
      context.read<AddStoreBloc>().add(SaveButtonEvent(true));
    } else {
      context.read<AddStoreBloc>().add(SaveButtonEvent(false));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddStoreBloc, AddStoreState>(
      listener: (context, state) {
        // checkEmpty();
        if (state is AddStoreSuccessState) {
          widget.onChange();
          if (widget.store == null) {
            customToast(
                context, AppLocalizations.of(context)!.successfullyAddedStore);
          } else {
            customToast(
                context, AppLocalizations.of(context)!.updateSuccessful);
          }
          Navigator.pop(context);
          Navigator.pop(context);
        }
        if (state is AddStoreLoadingState) {
          loadingAnimation(context);
        }
        if (state is AddStoreErrorState) {
          customToast(context, state.status);
          Navigator.pop(context);
        }
        if (state is ChangeCloseState ||
            state is ChangeOpenState ||
            state is ChangeAddressState ||
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
              storeImage(),
              const SizedBox(height: 30),
              descriptionLine(text: AppLocalizations.of(context)!.nameTheStore),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: nameController,
                hint: AppLocalizations.of(context)!.nameTheStore,
                title: AppLocalizations.of(context)!.nameTheStore,
              ),
              const SizedBox(height: 10),
              descriptionLine(text: AppLocalizations.of(context)!.phoneNumber),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: phoneController,
                hint: AppLocalizations.of(context)!.phoneNumber,
                title: AppLocalizations.of(context)!.phoneNumber,
                typeInput: const [TypeInput.phone],
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9+]")),
                ],
              ),
              const SizedBox(height: 10),
              descriptionLine(text: AppLocalizations.of(context)!.openingHours),
              const SizedBox(height: 10),
              openStore(),
              const SizedBox(height: 10),
              descriptionLine(text: AppLocalizations.of(context)!.closingTime),
              const SizedBox(height: 10),
              closeStore(),
              const SizedBox(height: 10),
              pickAddress(),
              const SizedBox(height: 10),
              descriptionLine(text: AppLocalizations.of(context)!.address),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: addressController,
                hint: AppLocalizations.of(context)!.address,
                title: AppLocalizations.of(context)!.address,
              ),
              const SizedBox(height: 10),
              saveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget pickAddress() {
    return BlocBuilder<AddStoreBloc, AddStoreState>(
      buildWhen: (previous, current) => current is ChangeAddressState,
      builder: (context, state) {
        return Column(
          children: [
            descriptionLine(text: AppLocalizations.of(context)!.country),
            const SizedBox(height: 10),
            const CountryDropdown(),
            const SizedBox(height: 10),
            descriptionLine(text: AppLocalizations.of(context)!.provinceCity),
            const SizedBox(height: 10),
            ProvinceDropdown(
              selectedValue: addressAPI.province?.name,
              onChange: (value) {
                addressAPI = addressAPI.copyWith(
                    province: value, district: null, ward: null);
                context.read<AddStoreBloc>().add(ChangeAddressEvent());
              },
            ),
            const SizedBox(height: 10),
            descriptionLine(text: AppLocalizations.of(context)!.district),
            const SizedBox(height: 10),
            DistrictDropdown(
              provinceID: addressAPI.province?.id,
              selectedValue: addressAPI.district?.name,
              onChange: (value) {
                addressAPI = addressAPI.copyWith(
                    province: addressAPI.province, district: value, ward: null);
                context.read<AddStoreBloc>().add(ChangeAddressEvent());
              },
            ),
            const SizedBox(height: 10),
            descriptionLine(text: AppLocalizations.of(context)!.ward),
            const SizedBox(height: 10),
            WardDropdown(
              provinceID: addressAPI.province?.id,
              districtID: addressAPI.district?.id,
              selectedValue: addressAPI.ward?.name,
              onChange: (value) {
                addressAPI = addressAPI.copyWith(
                  province: addressAPI.province,
                  district: addressAPI.district,
                  ward: value,
                );
                context.read<AddStoreBloc>().add(ChangeAddressEvent());
              },
            ),
          ],
        );
      },
    );
  }

  Widget openStore() {
    return BlocBuilder<AddStoreBloc, AddStoreState>(
      buildWhen: (previous, current) => current is ChangeOpenState,
      builder: (context, state) {
        return CustomPickerWidget(
          checkEdit: true,
          text: open?.toTimeString() ?? AppLocalizations.of(context)!.open,
          onPress: () async {
            open = await selectedTime(open);
            if (mounted) context.read<AddStoreBloc>().add(ChangeOpenEvent());
          },
        );
      },
    );
  }

  Widget closeStore() {
    return BlocBuilder<AddStoreBloc, AddStoreState>(
      buildWhen: (previous, current) => current is ChangeCloseState,
      builder: (context, state) {
        return CustomPickerWidget(
          checkEdit: true,
          text: close?.toTimeString() ?? AppLocalizations.of(context)!.close,
          onPress: () async {
            close = await selectedTime(close);
            if (mounted) context.read<AddStoreBloc>().add(ChangeCloseEvent());
          },
        );
      },
    );
  }

  Widget storeImage() {
    return BlocBuilder<AddStoreBloc, AddStoreState>(
      buildWhen: (previous, current) => current is ChangeImageState,
      builder: (context, state) {
        // checkEmpty();
        return InkWell(
          onTap: () => showMyBottomSheet(context, (image) {
            this.image = image;
            context
                .read<AddStoreBloc>()
                .add(ChangeImageEvent(image == null ? "" : image.path));
          }),
          child: widget.store == null
              ? (image == null
                  ? Image.asset(AppImages.imgAddImage, height: 150, width: 150)
                  : Image.file(image!, height: 150, width: 150))
              : CachedNetworkImage(
                  height: 150,
                  width: 150,
                  imageUrl:
                      "https://www.highlandscoffee.com.vn/vnt_upload/news/02_2020/83739091_2845644318849727_1748210367038750720_o_1.png",
                  placeholder: (context, url) => itemLoading(150, 150, 0),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
        );
      },
    );
  }

  Widget saveButton() {
    return BlocBuilder<AddStoreBloc, AddStoreState>(
      buildWhen: (previous, current) => current is SaveButtonState,
      builder: (context, state) {
        return customButton(
          text: AppLocalizations.of(context)!.save,
          isOnPress: state is SaveButtonState ? state.isContinue : false,
          onPress: () {
            if (_formKey.currentState!.validate()) {
              if (widget.store == null) {
                context.read<AddStoreBloc>().add(CreateStoreEvent(Store(
                      storeName: nameController.text,
                      hotlineNumber: phoneController.text,
                      address1: addressController.text,
                      address2: addressAPI.ward!.name,
                      address3: addressAPI.district!.name,
                      address4: addressAPI.province!.name,
                      openingHour: open!.toTimeString(),
                      closingHour: close!.toTimeString(),
                    )));
              } else {
                context.read<AddStoreBloc>().add(UpdateStoreEvent(Store(
                      storeId: widget.store!.storeId,
                      storeName: nameController.text,
                      hotlineNumber: phoneController.text,
                      address1: addressController.text,
                      address2: addressAPI.ward!.name,
                      address3: addressAPI.district!.name,
                      address4: addressAPI.province!.name,
                      openingHour: open!.toTimeString(),
                      closingHour: close!.toTimeString(),
                      imageUrl: widget.store!.imageUrl,
                      registrationDate: widget.store!.registrationDate,
                    )));
              }
            }
          },
        );
      },
    );
  }

  Future<TimeOfDay?> selectedTime(TimeOfDay? init) =>
      showTimePicker(initialTime: init ?? TimeOfDay.now(), context: context);
}
