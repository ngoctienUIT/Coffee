import 'dart:io';

import 'package:coffee_admin/src/core/function/loading_animation.dart';
import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:coffee_admin/src/core/utils/extensions/time_of_date_extension.dart';
import 'package:coffee_admin/src/data/models/address.dart';
import 'package:coffee_admin/src/data/models/store.dart';
import 'package:coffee_admin/src/presentation/add_store/widgets/district_dropdown.dart';
import 'package:coffee_admin/src/presentation/add_store/widgets/province_dropdown.dart';
import 'package:coffee_admin/src/presentation/add_store/widgets/ward_dropdown.dart';
import 'package:coffee_admin/src/presentation/forgot_password/widgets/app_bar_general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/utils/constants/constants.dart';
import '../../add_product/widgets/bottom_pick_image.dart';
import '../../login/widgets/custom_button.dart';
import '../../product/widgets/description_line.dart';
import '../../profile/widgets/custom_picker_widget.dart';
import '../../signup/widgets/custom_text_input.dart';
import '../bloc/add_store_bloc.dart';
import '../bloc/add_store_event.dart';
import '../bloc/add_store_state.dart';
import '../widgets/country_dropdown.dart';

class AddStorePage extends StatelessWidget {
  const AddStorePage({Key? key, this.store}) : super(key: key);

  final Store? store;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddStoreBloc(),
      child: Scaffold(
        appBar: const AppBarGeneral(elevation: 0, title: "Thêm cửa hàng"),
        body: AddStoreView(store: store),
      ),
    );
  }
}

class AddStoreView extends StatefulWidget {
  const AddStoreView({Key? key, this.store}) : super(key: key);

  final Store? store;

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
    }
    nameController.addListener(() => checkEmpty());
    phoneController.addListener(() => checkEmpty());
    addressController.addListener(() => checkEmpty());
    super.initState();
  }

  void checkEmpty() {
    if (nameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        image != null &&
        close != null &&
        open != null &&
        !addressAPI.checkNull()) {
      context.read<AddStoreBloc>().add(SaveButtonEvent(true));
    } else {
      context.read<AddStoreBloc>().add(SaveButtonEvent(false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddStoreBloc, AddStoreState>(
      listener: (context, state) {
        if (state is AddStoreSuccessState) {
          Fluttertoast.showToast(msg: "Thêm cửa hàng thành công");
          Navigator.pop(context);
          Navigator.pop(context);
        }
        if (state is AddStoreLoadingState) {
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
              storeImage(),
              const SizedBox(height: 30),
              descriptionLine(text: "Tên cửa hàng"),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: nameController,
                hint: "Tên cửa hàng",
                title: "Tên cửa hàng",
              ),
              const SizedBox(height: 10),
              descriptionLine(text: "Số điện thoại"),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: phoneController,
                hint: "Số điện thoại",
                title: "Số điện thoại",
              ),
              const SizedBox(height: 10),
              descriptionLine(text: "Giờ mở cửa"),
              const SizedBox(height: 10),
              openStore(),
              const SizedBox(height: 10),
              descriptionLine(text: "Giờ đóng cửa"),
              const SizedBox(height: 10),
              closeStore(),
              const SizedBox(height: 10),
              pickAddress(),
              const SizedBox(height: 10),
              descriptionLine(text: "Địa chỉ"),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: addressController,
                hint: "Địa chỉ",
                title: "Địa chỉ",
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
            descriptionLine(text: "Quốc gia"),
            const SizedBox(height: 10),
            const CountryDropdown(),
            const SizedBox(height: 10),
            descriptionLine(text: "Tỉnh/Thành phố"),
            const SizedBox(height: 10),
            ProvinceDropdown(
              selectedValue: addressAPI.province != null
                  ? addressAPI.province!.name
                  : null,
              onChange: (value) {
                addressAPI = addressAPI.copyWith(
                    province: value, district: null, ward: null);
                context.read<AddStoreBloc>().add(ChangeAddressEvent());
              },
            ),
            const SizedBox(height: 10),
            descriptionLine(text: "Quận/Huyện"),
            const SizedBox(height: 10),
            DistrictDropdown(
              provinceID:
                  addressAPI.province != null ? addressAPI.province!.id : null,
              selectedValue: addressAPI.district != null
                  ? addressAPI.district!.name
                  : null,
              onChange: (value) {
                addressAPI = addressAPI.copyWith(
                    province: addressAPI.province, district: value, ward: null);
                context.read<AddStoreBloc>().add(ChangeAddressEvent());
              },
            ),
            const SizedBox(height: 10),
            descriptionLine(text: "Xã/Phường"),
            const SizedBox(height: 10),
            WardDropdown(
              provinceID:
                  addressAPI.province != null ? addressAPI.province!.id : null,
              districtID:
                  addressAPI.district != null ? addressAPI.district!.id : null,
              selectedValue:
                  addressAPI.ward != null ? addressAPI.ward!.name : null,
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
          text: open == null ? "Mở cửa" : open!.toTimeString(),
          onPress: () async {
            open = await selectedTime();
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
          text: close == null ? "Đóng cửa" : close!.toTimeString(),
          onPress: () async {
            close = await selectedTime();
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
          child: image == null
              ? Image.asset(AppImages.imgAddImage, height: 150, width: 150)
              : Image.file(image!, height: 150, width: 150),
        );
      },
    );
  }

  Widget saveButton() {
    return BlocBuilder<AddStoreBloc, AddStoreState>(
      buildWhen: (previous, current) => current is SaveButtonState,
      builder: (context, state) {
        return customButton(
          text: "save".translate(context),
          isOnPress: state is SaveButtonState ? state.isContinue : false,
          onPress: () {
            if (_formKey.currentState!.validate()) {
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
            }
          },
        );
      },
    );
  }

  Future<TimeOfDay?> selectedTime() =>
      showTimePicker(initialTime: TimeOfDay.now(), context: context);
}
