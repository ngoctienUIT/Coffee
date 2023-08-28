import 'package:coffee_admin/injection.dart';
import 'package:coffee_admin/src/core/function/loading_animation.dart';
import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/services/bloc/service_bloc.dart';
import '../../../core/services/bloc/service_event.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../data/models/user.dart';
import '../../product/widgets/description_line.dart';
import '../../signup/widgets/custom_text_input.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import 'custom_picker_widget.dart';
import 'modal_gender.dart';

class BodyProfilePage extends StatefulWidget {
  const BodyProfilePage({Key? key, required this.user, this.onChange})
      : super(key: key);

  final User user;
  final VoidCallback? onChange;

  @override
  State<BodyProfilePage> createState() => _BodyProfilePageState();
}

class _BodyProfilePageState extends State<BodyProfilePage> {
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  bool isEdit = false;
  bool isMale = true;

  @override
  void initState() {
    surnameController.text = widget.user.displayName;
    nameController.text = widget.user.displayName;
    phoneController.text = widget.user.phoneNumber;
    emailController.text = widget.user.email;
    isMale = widget.user.isMale;
    if (widget.user.birthOfDate != null) {
      selectedDate = widget.user.birthOfDate!.toDate();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is SaveProfileLoaded) {
          context.read<ProfileBloc>().add(EditProfileEvent(isEdit: !isEdit));
          customToast(
              context, AppLocalizations.of(context)!.saveChangesSuccessfully);
          if (widget.onChange != null) {
            widget.onChange!.call();
          }
          Navigator.pop(context);
        }
        if (state is SaveProfileLoading) {
          loadingAnimation(context);
        }
        if (state is ProfileError) {
          customToast(context, state.message.toString());
          Navigator.pop(context);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
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
                return body();
              },
            ),
          ),
        ),
      ),
    );
  }

  void onSave() {
    User userIt = getIt<User>();
    if (isEdit) {
      if (_formKey.currentState!.validate()) {
        User user = widget.user.copyWith(
          displayName: nameController.text,
          isMale: isMale,
          birthOfDate: DateFormat("dd/MM/yyyy").format(selectedDate!),
        );
        if (user == userIt) {
          context.read<ProfileBloc>().add(EditProfileEvent(isEdit: !isEdit));
        } else {
          context.read<ProfileBloc>().add(SaveProfileEvent(user));
          if (user.email == userIt.email) {
            context.read<ServiceBloc>().add(ChangeUserInfoEvent(user));
          }
        }
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
            descriptionLine(text: AppLocalizations.of(context)!.generalInfo),
            const Spacer(),
            TextButton(
              onPressed: onSave,
              child: Text(
                isEdit
                    ? AppLocalizations.of(context)!.save
                    : AppLocalizations.of(context)!.edit,
              ),
            ),
          ],
        ),
        CustomTextInput(
          controller: nameController,
          hint: AppLocalizations.of(context)!.name,
          validator: (value) {
            if (value!.isEmpty) {
              return "${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.name.toLowerCase()}";
            }
            return null;
          },
          checkEdit: isEdit,
        ),
        const SizedBox(height: 10),
        CustomPickerWidget(
          checkEdit: isEdit,
          text: isMale
              ? AppLocalizations.of(context)!.male
              : AppLocalizations.of(context)!.female,
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
              ? AppLocalizations.of(context)!.birthday
              : DateFormat("dd/MM/yyyy").format(selectedDate!),
          onPress: () => selectDate(),
        ),
        const SizedBox(height: 10),
        descriptionLine(text: AppLocalizations.of(context)!.phoneNumber),
        const SizedBox(height: 10),
        CustomTextInput(
          controller: phoneController,
          hint: AppLocalizations.of(context)!.phoneNumber,
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
      ],
    );
  }

  void selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      if (mounted) context.read<ProfileBloc>().add(ChangeBirthDayEvent());
    }
  }
}
