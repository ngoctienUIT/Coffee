import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import '../../../core/function/on_will_pop.dart';
import '../../../core/function/route_function.dart';
import '../../../core/language/bloc/language_cubit.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../core/utils/enum/enums.dart';
import '../../forgot_password/screen/forgot_password_page.dart';
import '../../main/screen/main_page.dart';
import '../../signup/widgets/custom_text_input.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_password_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgCreamColor,
      body: WillPopScope(
        onWillPop: () => onWillPop(
          action: (now) => currentBackPressTime = now,
          currentBackPressTime: currentBackPressTime,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BlocProvider<LoginBloc>(
              create: (_) => LoginBloc(),
              child: const LoginView(),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isRemember = false;
  bool hide = true;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      isRemember = value.getBool("isRemember") ?? false;
      phoneController.text = isRemember ? value.getString("username")! : "";
      passwordController.text = isRemember ? value.getString("password")! : "";
      context.read<LoginBloc>().add(ClickLoginEvent(isContinue: isRemember));
      context.read<LoginBloc>().add(RememberLoginEvent());
    });
    passwordController.addListener(() => checkEmpty());
    phoneController.addListener(() => checkEmpty());
    super.initState();
  }

  void checkEmpty() {
    if (phoneController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      context.read<LoginBloc>().add(ClickLoginEvent(isContinue: true));
    } else {
      context.read<LoginBloc>().add(ClickLoginEvent(isContinue: false));
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future saveLogin() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLogin", true);
    prefs.setBool('isRemember', isRemember);
    prefs.setString('username', phoneController.text);
    prefs.setString('password', passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          isLogin = true;
          Fluttertoast.showToast(msg: "Đăng nhập thành công");
          saveLogin();
          context
              .read<LanguageCubit>()
              .startNewTimer(context, const Duration(hours: 1));
          Navigator.of(context).pushReplacement(createRoute(
            screen: const MainPage(),
            begin: const Offset(0, 1),
          ));
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height - 35,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            loginTitle(),
            const SizedBox(height: 20),
            loginInput(),
            rememberLogin(),
            const SizedBox(height: 10),
            loginButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget loginTitle() {
    return Column(
      children: [
        ClipOval(
          child: Image.asset(AppImages.imgLogo, height: 200),
        ),
        const SizedBox(height: 20),
        Text(
          "welcome_admin".translate(context),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget loginInput() {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: CustomTextInput(
            controller: phoneController,
            hint: "Email",
            keyboardType: TextInputType.emailAddress,
            typeInput: const [TypeInput.email],
            // inputFormatters: [
            //   FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
            // ],
          ),
        ),
        const SizedBox(height: 10),
        BlocBuilder<LoginBloc, LoginState>(
          buildWhen: (previous, current) => current is HidePasswordState,
          builder: (context, state) {
            return CustomPasswordInput(
              controller: passwordController,
              hint: "password".translate(context),
              onPress: () {
                context.read<LoginBloc>().add(HidePasswordEvent(isHide: !hide));
                hide = !hide;
              },
              hide: state is HidePasswordState ? state.isHide : true,
            );
          },
        ),
      ],
    );
  }

  Widget rememberLogin() {
    return Row(
      children: [
        BlocBuilder<LoginBloc, LoginState>(
          buildWhen: (previous, current) => current is RememberState,
          builder: (context, state) {
            return Checkbox(
              value: isRemember,
              onChanged: (value) {
                isRemember = value!;
                context.read<LoginBloc>().add(RememberLoginEvent());
              },
            );
          },
        ),
        Text("remember_login".translate(context)),
        const Spacer(),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(createRoute(
              screen: const ForgotPasswordPage(),
              begin: const Offset(1, 0),
            ));
          },
          child: Text("${"forgot_password".translate(context)}?"),
        )
      ],
    );
  }

  Widget loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => current is ContinueState,
      builder: (context, state) {
        return customButton(
          text: "continue".translate(context).toUpperCase(),
          isOnPress: state is ContinueState ? state.isContinue : false,
          onPress: () {
            if (_formKey.currentState!.validate()) {
              context.read<LoginBloc>().add(LoginWithEmailPasswordEvent(
                    email: phoneController.text,
                    password: passwordController.text,
                  ));
            }
          },
        );
      },
    );
  }
}
