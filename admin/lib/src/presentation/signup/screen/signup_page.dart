import 'dart:convert';

import 'package:coffee_admin/injection.dart';
import 'package:coffee_admin/src/core/function/loading_animation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:crypto/crypto.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../core/utils/enum/enums.dart';
import '../../../data/models/user.dart';
import '../../login/widgets/custom_button.dart';
import '../../login/widgets/custom_password_input.dart';
import '../../profile/widgets/custom_picker_widget.dart';
import '../../profile/widgets/modal_gender.dart';
import '../bloc/signup_bloc.dart';
import '../bloc/signup_event.dart';
import '../bloc/signup_state.dart';
import '../widgets/custom_text_input.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key, required this.role}) : super(key: key);

  final String role;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: BlocProvider<SignUpBloc>(
            create: (context) => getIt<SignUpBloc>(),
            child: SignUpView(role: role),
          ),
        ),
      ),
    );
  }
}

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key, required this.role}) : super(key: key);

  final String role;

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool hide = true;
  String selectedRole = "ADMIN";
  bool isMale = true;
  DateTime? selectedDate;

  @override
  void initState() {
    phoneController.addListener(() => checkEmpty());
    passwordController.addListener(() {
      context.read<SignUpBloc>().add(TextChangeEvent());
      checkEmpty();
    });
    confirmPasswordController.addListener(() {
      context.read<SignUpBloc>().add(TextChangeEvent());
      checkEmpty();
    });
    nameController.addListener(() => checkEmpty());
    emailController.addListener(() => checkEmpty());
    selectedRole = widget.role;
    super.initState();
  }

  void checkEmpty() {
    if (phoneController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
      context.read<SignUpBloc>().add(ClickSignUpEvent(isContinue: true));
    } else {
      context.read<SignUpBloc>().add(ClickSignUpEvent(isContinue: false));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoadingState) loadingAnimation(context);
        if (state is SignUpSuccessState) {
          Navigator.pop(context);
          customToast(context,
              AppLocalizations.of(context)!.accountSuccessfullyCreated);
        }
        if (state is SignUpErrorState) {
          customToast(context, state.status);
          Navigator.pop(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              signUpTitle(),
              const SizedBox(height: 20),
              userRole(),
              const SizedBox(height: 10),
              registerInfo(),
              const SizedBox(height: 20),
              signUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget signUpTitle() {
    return Column(
      children: [
        ClipOval(
          child: Image.asset(AppImages.imgLogo, height: 200),
        ),
        const SizedBox(height: 10),
        Text(
          AppLocalizations.of(context)!.addNewStaff,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget userRole() {
    return DropdownButtonFormField2(
      decoration: const InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.only(right: 10),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderColor, width: 0.7),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderColor, width: 0.7),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderColor, width: 0.7),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderColor, width: 0.7),
        ),
      ),
      buttonStyleData: const ButtonStyleData(height: 50),
      isExpanded: true,
      value: selectedRole,
      items: (widget.role == "ADMIN" ? ["ADMIN", "STAFF"] : ["STAFF"])
          .map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(fontSize: 16))))
          .toList(),
      onChanged: (value) => selectedRole = value!,
    );
  }

  Widget registerInfo() {
    return Column(
      children: [
        registerName(),
        const SizedBox(height: 10),
        CustomPickerWidget(
          checkEdit: true,
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
        birthday(),
        const SizedBox(height: 10),
        registerContact(),
        passwordInput(),
      ],
    );
  }

  Widget birthday() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => current is ChangeBirthdayState,
      builder: (context, state) {
        return CustomPickerWidget(
          checkEdit: true,
          text: selectedDate == null
              ? AppLocalizations.of(context)!.birthday
              : DateFormat("dd/MM/yyyy").format(selectedDate!),
          onPress: () => selectDate(),
        );
      },
    );
  }

  Widget registerName() {
    return CustomTextInput(
      controller: nameController,
      hint: AppLocalizations.of(context)!.name,
      title: AppLocalizations.of(context)!.name.toLowerCase(),
      typeInput: const [TypeInput.text],
    );
  }

  Widget registerContact() {
    return Column(
      children: [
        CustomTextInput(
          controller: phoneController,
          hint: AppLocalizations.of(context)!.phoneNumber,
          typeInput: const [TypeInput.phone],
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9+]")),
            LengthLimitingTextInputFormatter(11),
          ],
        ),
        const SizedBox(height: 10),
        CustomTextInput(
          controller: emailController,
          typeInput: const [TypeInput.email],
          hint: "Email",
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  Widget passwordInput() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) =>
          current is HidePasswordState || current is TextChangeState,
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(height: 10),
            CustomPasswordInput(
              controller: passwordController,
              hint: AppLocalizations.of(context)!.password,
              onPress: () {
                context
                    .read<SignUpBloc>()
                    .add(HidePasswordEvent(isHide: !hide));
                hide = !hide;
              },
              hide: state is HidePasswordState ? state.isHide : hide,
            ),
            const SizedBox(height: 10),
            CustomPasswordInput(
              controller: confirmPasswordController,
              hint: AppLocalizations.of(context)!.confirmPassword,
              confirmPassword: passwordController.text,
              onPress: () {
                context
                    .read<SignUpBloc>()
                    .add(HidePasswordEvent(isHide: !hide));
                hide = !hide;
              },
              hide: state is HidePasswordState ? state.isHide : hide,
            ),
          ],
        );
      },
    );
  }

  Widget signUpButton() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => current is ContinueState,
      builder: (context, state) {
        return customButton(
          text: AppLocalizations.of(context)!.continue1,
          isOnPress: state is ContinueState ? state.isContinue : false,
          onPress: () {
            if (_formKey.currentState!.validate()) {
              var bytes = utf8.encode(passwordController.text);
              var digest = sha256.convert(bytes);
              print("Digest as hex string: $digest");
              context.read<SignUpBloc>().add(SignUpWithEmailPasswordEvent(
                      user: User(
                    username: emailController.text,
                    displayName: nameController.text,
                    isMale: isMale,
                    email: emailController.text,
                    phoneNumber: phoneController.text,
                    password: digest.toString(),
                    userRole: selectedRole,
                    birthOfDate: DateFormat("dd/MM/yyyy").format(selectedDate!),
                  )));
            }
          },
        );
      },
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
      if (mounted) {
        context.read<SignUpBloc>().add(ChangeBirthdayEvent());
        checkEmpty();
      }
    }
  }
}
