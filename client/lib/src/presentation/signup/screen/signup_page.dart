import 'package:coffee/main.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/login/screen/login_page.dart';
import 'package:coffee/src/presentation/register_info/screen/register_info_page.dart';
import 'package:coffee/src/presentation/signup/bloc/signup_bloc.dart';
import 'package:coffee/src/presentation/signup/bloc/signup_event.dart';
import 'package:coffee/src/presentation/signup/bloc/signup_state.dart';
import 'package:coffee/src/presentation/signup/widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/function/on_will_pop.dart';
import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../core/utils/enum/enums.dart';
import '../../login/widgets/custom_button.dart';
import '../../login/widgets/social_login_button.dart';
import '../../main/screen/main_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    bool canPop = ModalRoute.of(context)!.canPop;
    return Scaffold(
      backgroundColor: AppColors.bgCreamColor,
      appBar: canPop ? appBar() : null,
      body: WillPopScope(
        onWillPop: () => onWillPop(
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

  AppBar appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.close),
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
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isContinue = false;

  @override
  void initState() {
    phoneController.addListener(() {
      if (phoneController.text.isNotEmpty) {
        context.read<SignUpBloc>().add(ClickSignUpEvent(isContinue: true));
      } else {
        context.read<SignUpBloc>().add(ClickSignUpEvent(isContinue: false));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccessState) {
          Navigator.of(context).pushReplacement(createRoute(
            screen: const MainPage(),
            begin: const Offset(0, 1),
          ));
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height - 35,
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              signUpTitle(),
              const SizedBox(height: 20),
              signUpInput(),
              const SizedBox(height: 20),
              signUpButton(),
              const SizedBox(height: 20),
              socialSignUp(),
              const SizedBox(height: 20),
              continueGuest(),
              const Spacer(),
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

  Widget signUpInput() {
    return CustomTextInput(
      controller: phoneController,
      hint: "email_phone_number".translate(context),
      typeInput: const [TypeInput.phone, TypeInput.email],
      keyboardType: TextInputType.emailAddress,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
      ],
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
              Navigator.of(context).push(createRoute(
                screen: const RegisterInfoPage(),
                begin: const Offset(0, 1),
              ));
              // context.read<SignUpBloc>().add(SignUpWithEmailPasswordEvent(
              //     email: phoneController.text, password: "password"));
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialLoginButton(
              icon: FontAwesomeIcons.google,
              color: Colors.red,
              onPress: () {
                context.read<SignUpBloc>().add(SignUpWithGoogleEvent());
              },
            ),
            SocialLoginButton(
              icon: FontAwesomeIcons.facebook,
              color: Colors.blue,
              onPress: () {
                context.read<SignUpBloc>().add(SignUpWithFacebookEvent());
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget continueGuest() {
    return TextButton(
      onPressed: () {
        isLogin = false;
        Navigator.of(context).pushReplacement(createRoute(
          screen: const MainPage(),
          begin: const Offset(0, 1),
        ));
      },
      child: Text("continue_guest".translate(context).toUpperCase()),
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
}
