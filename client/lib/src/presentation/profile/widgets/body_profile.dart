import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/data/models/user.dart';
import 'package:coffee/src/presentation/home/widgets/description_line.dart';
import 'package:coffee/src/presentation/profile/bloc/profile_bloc.dart';
import 'package:coffee/src/presentation/profile/bloc/profile_event.dart';
import 'package:coffee/src/presentation/profile/bloc/profile_state.dart';
import 'package:coffee/src/presentation/profile/widgets/custom_picker_widget.dart';
import 'package:coffee/src/presentation/signup/widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/constants/constants.dart';
import '../../../core/utils/enum/enums.dart';
import '../../../domain/entities/user/user_response.dart';
import 'modal_gender.dart';

class BodyProfilePage extends StatefulWidget {
  const BodyProfilePage({Key? key, required this.user, required this.onChange})
      : super(key: key);

  final UserResponse user;
  final VoidCallback onChange;

  @override
  State<BodyProfilePage> createState() => _BodyProfilePageState();
}

class _BodyProfilePageState extends State<BodyProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  bool isEdit = false;
  bool isMale = true;
  bool isLink = false;

  @override
  void initState() {
    nameController.text = widget.user.displayName;
    phoneController.text = widget.user.phoneNumber;
    emailController.text = widget.user.email;
    if (widget.user.accountProvider != null) {
      isLink = widget.user.accountProvider!.google != null;
    }
    isMale = widget.user.isMale;
    if (widget.user.birthOfDate != null) {
      selectedDate = widget.user.birthOfDate!.toDate();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listenWhen: (previous, current) =>
          current is SaveProfileLoaded ||
          current is LinkAccountWithGoogleSuccessState ||
          current is UnlinkAccountWithGoogleSuccessState,
      listener: (context, state) {
        if (state is SaveProfileLoaded) {
          context.read<ProfileBloc>().add(EditProfileEvent(isEdit: !isEdit));
          Fluttertoast.showToast(msg: "Lưu thay đổi thành công");
          widget.onChange();
        }
        if (state is LinkAccountWithGoogleSuccessState) {
          Fluttertoast.showToast(
              msg: "Liên kết tài khoản Google thành công");
          widget.onChange();
        }
        if (state is UnlinkAccountWithGoogleSuccessState) {
          Fluttertoast.showToast(
              msg: "Hủy liên kết tài khoản Google thành công");
          widget.onChange();
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          color: AppColors.bgColor,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is EditProfileSate) isEdit = state.isEdit;
                return Column(
                  children: [
                    Padding(padding: const EdgeInsets.all(10), child: body()),
                    linkGoogle(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget linkGoogle() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) =>
          current is InitState ||
          current is LinkAccountWithGoogleLoadingState ||
          current is LinkAccountWithGoogleSuccessState ||
          current is LinkAccountWithGoogleErrorState,
      builder: (context, state) {
        if (state is LinkAccountWithGoogleLoadingState ||
            state is LinkAccountWithGoogleSuccessState ||
            state is UnlinkAccountWithGoogleLoadingState ||
            state is UnlinkAccountWithGoogleSuccessState) {
          isLink = true;
        }
        if (state is LinkAccountWithGoogleErrorState ||
            state is UnlinkAccountWithGoogleErrorState) {
          isLink = false;
        }
        return Container(
          height: 50,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Image.asset(AppImages.imgGoogle, height: 40),
              const SizedBox(width: 10),
              const Text("Google"),
              const Spacer(),
              Switch(
                value: isLink,
                onChanged: (value) {
                  isLink = !isLink;
                  print(widget.user.accountProvider);
                  if (isLink &&
                      widget.user.accountProvider != null &&
                      widget.user.accountProvider!.google == null) {
                    context
                        .read<ProfileBloc>()
                        .add(LinkAccountWithGoogleEvent());
                  } else {
                    context
                        .read<ProfileBloc>()
                        .add(UnlinkAccountWithGoogleEvent());
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void onSave() {
    if (isEdit) {
      if (_formKey.currentState!.validate()) {
        context
            .read<ProfileBloc>()
            .add(SaveProfileEvent(User.fromUserResponse(widget.user).copyWith(
              displayName: nameController.text,
              isMale: isMale,
              birthOfDate: DateFormat("dd/MM/yyyy").format(selectedDate!),
            )));
      }
    } else {
      context.read<ProfileBloc>().add(EditProfileEvent(isEdit: !isEdit));
    }
  }

  Widget body() {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            descriptionLine(text: "general_info".translate(context)),
            const Spacer(),
            TextButton(
              onPressed: onSave,
              child: Text(
                (isEdit ? "save" : "edit").translate(context),
              ),
            ),
          ],
        ),
        CustomTextInput(
          controller: nameController,
          hint: "name".translate(context),
          title: "name".translate(context).toLowerCase(),
          typeInput: const [TypeInput.text],
          checkEdit: isEdit,
        ),
        const SizedBox(height: 10),
        CustomPickerWidget(
          checkEdit: isEdit,
          text:
              isMale ? "male".translate(context) : "female".translate(context),
          onPress: () => showMyBottomSheet(
            context: context,
            isMale: isMale,
            onPress: (isMale) {
              Navigator.pop(context);
              setState(() => this.isMale = isMale);
            },
          ),
        ),
        const SizedBox(height: 10),
        CustomPickerWidget(
          checkEdit: isEdit,
          text: selectedDate == null
              ? "birthday".translate(context)
              : DateFormat("dd/MM/yyyy").format(selectedDate!),
          onPress: () => selectDate(),
        ),
        const SizedBox(height: 10),
        descriptionLine(text: "phone_number".translate(context)),
        const SizedBox(height: 10),
        CustomTextInput(
          controller: phoneController,
          hint: "phone_number".translate(context),
          checkEdit: false,
        ),
        const SizedBox(height: 10),
        descriptionLine(text: "Email"),
        const SizedBox(height: 10),
        CustomTextInput(
          controller: emailController,
          hint: "Email",
          checkEdit: false,
        ),
        const SizedBox(height: 10),
        descriptionLine(text: "affiliate_account".translate(context)),
      ],
    );
  }

  void selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      if (mounted) context.read<ProfileBloc>().add(ChangeBirthdayEvent());
    }
  }
}
