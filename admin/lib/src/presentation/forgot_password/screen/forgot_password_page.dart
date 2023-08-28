import 'package:coffee_admin/injection.dart';
import 'package:coffee_admin/src/core/function/custom_toast.dart';
import 'package:coffee_admin/src/core/function/loading_animation.dart';
import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:coffee_admin/src/presentation/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:coffee_admin/src/presentation/forgot_password/bloc/forgot_password_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../input_pin/screen/input_pin.dart';
import '../../login/widgets/custom_button.dart';
import '../../signup/widgets/custom_text_input.dart';
import '../bloc/forgot_password_state.dart';
import '../widgets/app_bar_general.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgotPasswordBloc>(
      create: (context) => getIt<ForgotPasswordBloc>(),
      child: const ForgotPasswordView(),
    );
  }
}

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller.addListener(() {
      if (controller.text.isEmpty) {
        context.read<ForgotPasswordBloc>().add(ShowButtonEvent(false));
      } else {
        context.read<ForgotPasswordBloc>().add(ShowButtonEvent(true));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state is LoadingState) loadingAnimation(context);
        if (state is SuccessState) {
          Navigator.pop(context);
          Navigator.of(context).push(createRoute(
            screen: InputPinPage(resetCredential: state.resetCredential),
            begin: const Offset(1, 0),
          ));
        }
        if (state is ErrorState) {
          customToast(context, state.status);
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: const AppBarGeneral(elevation: 0),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      AppImages.imgLogo,
                      height: 200,
                    ),
                  ),
                  Text(AppLocalizations.of(context)!.forgotYourPassword),
                  const SizedBox(height: 20),
                  CustomTextInput(
                    controller: controller,
                    hint: "Email",
                    validator: (value) {
                      if (!value!.isValidEmail() && !value.isOnlyNumbers() ||
                          value.isEmpty) {
                        return AppLocalizations.of(context)!.pleaseEnterEmail;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(AppLocalizations.of(context)!
                      .enterEmailPhoneResetPassword),
                  const SizedBox(height: 50),
                  continueButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget continueButton() {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      buildWhen: (previous, current) => current is ContinueState,
      builder: (context, state) {
        return customButton(
          text: AppLocalizations.of(context)!.continue1,
          onPress: () {
            if (_formKey.currentState!.validate()) {
              context
                  .read<ForgotPasswordBloc>()
                  .add(SendForgotPasswordEvent(controller.text));
            }
          },
          isOnPress: state is ContinueState ? state.isContinue : false,
        );
      },
    );
  }
}
