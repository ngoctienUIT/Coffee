import 'package:coffee_admin/injection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/function/loading_animation.dart';
import '../../../core/function/route_function.dart';
import '../../forgot_password/widgets/app_bar_general.dart';
import '../../login/screen/login_page.dart';
import '../../login/widgets/custom_button.dart';
import '../../login/widgets/custom_password_input.dart';
import '../bloc/new_password_bloc.dart';
import '../bloc/new_password_event.dart';
import '../bloc/new_password_state.dart';

class NewPasswordPage extends StatelessWidget {
  const NewPasswordPage({Key? key, required this.resetCredential})
      : super(key: key);

  final String resetCredential;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewPasswordBloc>(
      create: (context) => getIt<NewPasswordBloc>(),
      child: NewPasswordView(resetCredential: resetCredential),
    );
  }
}

class NewPasswordView extends StatefulWidget {
  const NewPasswordView({Key? key, required this.resetCredential})
      : super(key: key);

  final String resetCredential;

  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isHide = true;

  @override
  void initState() {
    newPasswordController.addListener(() {
      checkEmpty();
      context.read<NewPasswordBloc>().add(TextChangeEvent());
    });
    confirmPasswordController.addListener(() {
      checkEmpty();
      context.read<NewPasswordBloc>().add(TextChangeEvent());
    });
    super.initState();
  }

  void checkEmpty() {
    if (newPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      context
          .read<NewPasswordBloc>()
          .add(ShowChangeButtonEvent(isContinue: true));
    } else {
      context
          .read<NewPasswordBloc>()
          .add(ShowChangeButtonEvent(isContinue: false));
    }
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewPasswordBloc, NewPasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccessState) {
          Navigator.of(context).pushAndRemoveUntil(
            createRoute(
              screen: const LoginPage(),
              begin: const Offset(0, 1),
            ),
            (route) => false,
          );
        }
        if (state is ChangePasswordLoadingState) {
          loadingAnimation(context);
        }
        if (state is ChangePasswordErrorState) {
          customToast(context, state.status);
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: const AppBarGeneral(elevation: 0),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.changePassword,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(AppLocalizations.of(context)!.passwordNeedsCharacters),
                const SizedBox(height: 10),
                inputPassword(),
                const Spacer(),
                const SizedBox(height: 10),
                buttonWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonWidget() {
    return BlocBuilder<NewPasswordBloc, NewPasswordState>(
      buildWhen: (previous, current) =>
          current is ContinueState || current is InitState,
      builder: (context, state) {
        return customButton(
          text: AppLocalizations.of(context)!.changePassword,
          isOnPress: state is ContinueState ? state.isContinue : false,
          onPress: () {
            if (_formKey.currentState!.validate()) {
              context.read<NewPasswordBloc>().add(ChangePasswordEvent(
                  widget.resetCredential, newPasswordController.text));
            }
          },
        );
      },
    );
  }

  Widget inputPassword() {
    return BlocBuilder<NewPasswordBloc, NewPasswordState>(
      buildWhen: (previous, current) => current is! ContinueState,
      builder: (context, state) {
        return Column(
          children: [
            CustomPasswordInput(
              controller: newPasswordController,
              hint: AppLocalizations.of(context)!.enterNewPassword,
              hide: isHide,
              onPress: () {
                isHide = !isHide;
                context.read<NewPasswordBloc>().add(HidePasswordEvent());
              },
            ),
            const SizedBox(height: 10),
            CustomPasswordInput(
              controller: confirmPasswordController,
              confirmPassword: newPasswordController.text,
              hint: AppLocalizations.of(context)!.confirmPassword,
              hide: isHide,
              onPress: () {
                isHide = !isHide;
                context.read<NewPasswordBloc>().add(HidePasswordEvent());
              },
            ),
          ],
        );
      },
    );
  }
}
