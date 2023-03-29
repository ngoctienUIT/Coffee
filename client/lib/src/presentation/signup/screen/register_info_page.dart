import 'package:coffee/src/core/utils/constants/app_colors.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/data/models/user.dart';
import 'package:coffee/src/presentation/login/widgets/custom_button.dart';
import 'package:coffee/src/presentation/signup/bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import '../../../core/function/route_function.dart';
import '../../../core/utils/enum/enums.dart';
import '../../home/widgets/description_line.dart';
import '../../login/widgets/custom_password_input.dart';
import '../../main/screen/main_page.dart';
import '../../profile/widgets/custom_picker_widget.dart';
import '../../profile/widgets/modal_gender.dart';
import '../bloc/signup_event.dart';
import '../bloc/signup_state.dart';
import '../widgets/custom_text_input.dart';

class RegisterInfoPage extends StatelessWidget {
  const RegisterInfoPage({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("customer_info".translate(context)),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: RegisterInfoView(username: username),
      ),
    );
  }
}

class RegisterInfoView extends StatefulWidget {
  const RegisterInfoView({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  State<RegisterInfoView> createState() => _RegisterInfoViewState();
}

class _RegisterInfoViewState extends State<RegisterInfoView> {
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool hide = true;

  @override
  void initState() {
    if (widget.username.isValidPhone()) {
      phoneController.text = widget.username;
    } else {
      emailController.text = widget.username;
    }
    super.initState();
  }

  Future saveSignUp() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLogin", true);
    prefs.setBool('isRemember', false);
    prefs.setString('username', widget.username);
    prefs.setString('password', passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccessState) {
          isLogin = true;
          saveSignUp();
          Navigator.of(context).pushReplacement(createRoute(
            screen: const MainPage(),
            begin: const Offset(0, 1),
          ));
        }
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                descriptionLine(
                  text: "personal_info".translate(context),
                  color: AppColors.statusBarColor,
                  margin: EdgeInsets.zero,
                  fontSize: 16,
                ),
                const SizedBox(height: 10),
                registerName(),
                const SizedBox(height: 10),
                CustomPickerWidget(
                  checkEdit: true,
                  text: true
                      ? "male".translate(context)
                      : "female".translate(context),
                  onPress: () => showMyBottomSheet(
                    context: context,
                    isMale: true,
                    onPress: (isMale) {
                      Navigator.pop(context);
                      // setState(() => this.isMale = isMale);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                CustomPickerWidget(
                  checkEdit: true,
                  text: "birthday".translate(context),
                  // onPress: () => selectDate(),
                ),
                const SizedBox(height: 10),
                registerContact(),
                passwordInput(),
                const Spacer(),
                nextButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget registerName() {
    return Row(
      children: [
        Expanded(
          child: CustomTextInput(
            controller: surnameController,
            hint: "surname".translate(context),
            typeInput: const [TypeInput.text],
            title: "surname".translate(context).toLowerCase(),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomTextInput(
            controller: nameController,
            hint: "name".translate(context),
            title: "name".translate(context).toLowerCase(),
            typeInput: const [TypeInput.text],
          ),
        ),
      ],
    );
  }

  Widget registerContact() {
    return Column(
      children: [
        CustomTextInput(
          controller: phoneController,
          hint: "phone_number".translate(context),
          typeInput: const [TypeInput.phone],
          onPress: widget.username.isValidPhone() ? () {} : null,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 10),
        CustomTextInput(
          controller: emailController,
          typeInput: const [TypeInput.email],
          hint: "Email",
          onPress: widget.username.isValidEmail() ? () {} : null,
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  Widget nextButton() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => current is ContinueState,
      builder: (context, state) {
        return customButton(
          isOnPress: true,
          text: "next".translate(context).toUpperCase(),
          onPress: () {
            if (_formKey.currentState!.validate()) {
              context.read<SignUpBloc>().add(SignUpWithEmailPasswordEvent(
                    user: User(
                      username: widget.username,
                      displayName: surnameController.text + nameController.text,
                      isMale: true,
                      email: emailController.text,
                      phoneNumber: phoneController.text,
                      password: passwordController.text,
                    ),
                  ));
            }
          },
        );
      },
    );
  }

  Widget passwordInput() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => current is HidePasswordState,
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
              hide: state is HidePasswordState ? state.isHide : true,
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
              hide: state is HidePasswordState ? state.isHide : true,
            ),
          ],
        );
      },
    );
  }
}
