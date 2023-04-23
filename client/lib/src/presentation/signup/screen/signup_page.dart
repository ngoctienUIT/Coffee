import 'dart:convert';

import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/input_info/screen/input_info_page.dart';
import 'package:coffee/src/presentation/login/screen/login_page.dart';
import 'package:coffee/src/presentation/signup/bloc/signup_bloc.dart';
import 'package:coffee/src/presentation/signup/bloc/signup_event.dart';
import 'package:coffee/src/presentation/signup/bloc/signup_state.dart';
import 'package:coffee/src/presentation/signup/widgets/custom_text_input.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/function/on_will_pop.dart';
import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../core/utils/enum/enums.dart';
import '../../../data/models/user.dart';
import '../../login/widgets/custom_button.dart';
import '../../login/widgets/custom_password_input.dart';
import '../../login/widgets/social_login_button.dart';
import '../../profile/widgets/custom_picker_widget.dart';
import '../../profile/widgets/modal_gender.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgCreamColor,
      body: WillPopScope(
        onWillPop: () => onWillPop(
          context: context,
          action: (now) => currentBackPressTime = now,
          currentBackPressTime: currentBackPressTime,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BlocProvider(
              create: (context) => SignUpBloc(),
              child: const SignUpView(),
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

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
    super.initState();
  }

  void checkEmpty() {
    if (phoneController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        selectedDate != null) {
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
        if (state is SignUpSuccessState) {
          Navigator.of(context).pushReplacement(createRoute(
            screen: const LoginPage(),
            begin: const Offset(0, 1),
          ));
        }
        if (state is SignUpGoogleSuccessState) {
          Navigator.of(context).push(createRoute(
            screen: InputInfoPage(account: state.account),
            begin: const Offset(0, 1),
          ));
        }
        if (state is SignUpErrorState) {
          customToast(context, state.status);
        }
        if (state is SignUpGoogleErrorState) {
          customToast(context, state.status);
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
              const SizedBox(height: 10),
              registerInfo(),
              const SizedBox(height: 20),
              signUpButton(),
              const SizedBox(height: 20),
              socialSignUp(),
              const SizedBox(height: 20),
              login(),
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
          "start_journey".translate(context),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget registerInfo() {
    return Column(
      children: [
        registerName(),
        const SizedBox(height: 10),
        gender(),
        const SizedBox(height: 10),
        birthday(),
        const SizedBox(height: 10),
        registerContact(),
        passwordInput(),
      ],
    );
  }

  Widget gender() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => current is ChangeGenderState,
      builder: (context, state) {
        return CustomPickerWidget(
          checkEdit: true,
          text:
              isMale ? "male".translate(context) : "female".translate(context),
          onPress: () => showMyBottomSheet(
            context: context,
            isMale: isMale,
            onPress: (isMale) {
              this.isMale = isMale;
              context.read<SignUpBloc>().add(ChangeGenderEvent());
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  Widget birthday() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => current is ChangeBirthdayState,
      builder: (context, state) {
        checkEmpty();
        return CustomPickerWidget(
          checkEdit: true,
          text: selectedDate == null
              ? "birthday".translate(context)
              : DateFormat("dd/MM/yyyy").format(selectedDate!),
          onPress: () => selectDate(),
        );
      },
    );
  }

  Widget registerName() {
    return CustomTextInput(
      controller: nameController,
      hint: "name".translate(context),
      title: "name".translate(context).toLowerCase(),
      typeInput: const [TypeInput.text],
    );
  }

  Widget registerContact() {
    return Column(
      children: [
        CustomTextInput(
          controller: phoneController,
          hint: "phone_number".translate(context),
          typeInput: const [TypeInput.phone],
          keyboardType: TextInputType.phone,
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
              hint: "password".translate(context),
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
              hint: "confirm_password".translate(context),
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
          text: "continue".translate(context),
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
                    birthOfDate: DateFormat("dd/MM/yyyy").format(selectedDate!),
                  )));
            }
          },
        );
      },
    );
  }

  Widget socialSignUp() {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Divider(thickness: 1, color: Colors.black54),
            ),
            const SizedBox(width: 10),
            Text("or".translate(context)),
            const SizedBox(width: 10),
            const Expanded(
              child: Divider(thickness: 1, color: Colors.black54),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SocialLoginButton(
          text: "Sign up with Google",
          onPress: () {
            context.read<SignUpBloc>().add(SignUpWithGoogleEvent());
          },
        ),
      ],
    );
  }

  Widget login() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${"already_have_account".translate(context)}?"),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(createRoute(
              screen: const LoginPage(),
              begin: const Offset(0, 1),
            ));
          },
          child: Text("login".translate(context)),
        )
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
      if (mounted) context.read<SignUpBloc>().add(ChangeBirthdayEvent());
    }
  }
}
