import 'package:coffee/injection.dart';
import 'package:coffee/src/core/services/bloc/service_event.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:coffee/src/data/models/user.dart';
import 'package:coffee/src/presentation/home/widgets/description_line.dart';
import 'package:coffee/src/presentation/profile/bloc/profile_bloc.dart';
import 'package:coffee/src/presentation/profile/bloc/profile_event.dart';
import 'package:coffee/src/presentation/profile/bloc/profile_state.dart';
import 'package:coffee/src/presentation/profile/widgets/custom_picker_widget.dart';
import 'package:coffee/src/presentation/signup/widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/services/bloc/service_bloc.dart';
import '../../../core/utils/constants/constants.dart';
import 'modal_gender.dart';

class BodyProfilePage extends StatefulWidget {
  const BodyProfilePage({Key? key, required this.user}) : super(key: key);

  final User user;

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
          Navigator.pop(context);
          context.read<ProfileBloc>().add(EditProfileEvent(isEdit: !isEdit));
          context.read<ServiceBloc>().add(ChangeUserInfoEvent(state.user));
          customToast(
              context, AppLocalizations.of(context).saveChangesSuccessfully);
        }
        if (state is LinkAccountWithGoogleSuccessState) {
          customToast(context,
              AppLocalizations.of(context).googleAccountLinkSuccessful);
          context.read<ServiceBloc>().add(ChangeUserInfoEvent(
              getIt<User>().copyWith(isAccountProvider: true)));
        }
        if (state is UnlinkAccountWithGoogleSuccessState) {
          customToast(context,
              AppLocalizations.of(context).unlinkedGoogleAccountSuccessfully);
          context.read<ServiceBloc>().add(ChangeUserInfoEvent(
              getIt<User>().copyWith(isAccountProvider: false)));
        }
        if (state is LinkAccountWithGoogleErrorState) {
          customToast(context, state.message.toString());
        }
        if (state is UnlinkAccountWithGoogleErrorState) {
          customToast(context, state.message.toString());
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          color: AppColors.bgColor,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is EditProfileSate) isEdit = state.isEdit;
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: body(),
                    );
                  },
                ),
              ),
              linkGoogle(),
            ],
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
          current is LinkAccountWithGoogleErrorState ||
          current is UnlinkAccountWithGoogleLoadingState ||
          current is UnlinkAccountWithGoogleSuccessState ||
          current is UnlinkAccountWithGoogleErrorState,
      builder: (context, state) {
        if (state is LinkAccountWithGoogleLoadingState ||
            state is LinkAccountWithGoogleSuccessState ||
            state is UnlinkAccountWithGoogleErrorState) {
          isLink = true;
        }
        if (state is UnlinkAccountWithGoogleLoadingState ||
            state is UnlinkAccountWithGoogleSuccessState ||
            state is LinkAccountWithGoogleErrorState) {
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
                  if (widget.user.password.isNotEmpty) {
                    isLink = value;
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
                  } else {
                    customToast(context,
                        AppLocalizations.of(context).youCannotUnlinkGoogle);
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
        User user = widget.user.copyWith(
          displayName: nameController.text,
          isMale: isMale,
          birthOfDate: DateFormat("dd/MM/yyyy").format(selectedDate!),
        );
        if (user == getIt<User>()) {
          context.read<ProfileBloc>().add(EditProfileEvent(isEdit: !isEdit));
        } else {
          context.read<ProfileBloc>().add(SaveProfileEvent(user));
          context.read<ServiceBloc>().add(ChangeUserInfoEvent(user));
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
            descriptionLine(text: AppLocalizations.of(context).generalInfo),
            const Spacer(),
            TextButton(
              onPressed: onSave,
              child: Text(
                isEdit
                    ? AppLocalizations.of(context).save
                    : AppLocalizations.of(context).edit,
              ),
            ),
          ],
        ),
        CustomTextInput(
          controller: nameController,
          hint: AppLocalizations.of(context).name,
          validator: (value) {
            if (value!.isEmpty) {
              return "${AppLocalizations.of(context).pleaseEnter} ${AppLocalizations.of(context).name.toUpperCase()}";
            }
            return null;
          },
          checkEdit: isEdit,
        ),
        const SizedBox(height: 10),
        CustomPickerWidget(
          checkEdit: isEdit,
          text: isMale
              ? AppLocalizations.of(context).male
              : AppLocalizations.of(context).female,
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
              ? AppLocalizations.of(context).birthday
              : DateFormat("dd/MM/yyyy").format(selectedDate!),
          onPress: () => selectDate(),
        ),
        const SizedBox(height: 10),
        descriptionLine(text: AppLocalizations.of(context).phoneNumber),
        const SizedBox(height: 10),
        CustomTextInput(
          controller: phoneController,
          hint: AppLocalizations.of(context).phoneNumber,
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
        descriptionLine(text: AppLocalizations.of(context).affiliateAccount),
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
      if (mounted) context.read<ProfileBloc>().add(ChangeBirthdayEvent());
    }
  }
}
