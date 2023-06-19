import 'dart:convert';

import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/function/loading_animation.dart';
import '../../../core/services/bloc/service_bloc.dart';
import '../../../data/models/preferences_model.dart';
import '../../../data/models/user.dart';
import '../../forgot_password/widgets/app_bar_general.dart';
import '../../login/widgets/custom_button.dart';
import '../../login/widgets/custom_password_input.dart';
import '../bloc/change_password_bloc.dart';
import '../bloc/change_password_event.dart';
import '../bloc/change_password_state.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    PreferencesModel preferencesModel =
        context.read<ServiceBloc>().preferencesModel;
    return BlocProvider(
      create: (context) => ChangePasswordBloc(preferencesModel),
      child: Scaffold(
        appBar: const AppBarGeneral(elevation: 0),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ChangePasswordView(user: user),
        ),
      ),
    );
  }
}

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isContinue = false;
  bool hide = true;

  @override
  void initState() {
    oldPasswordController.addListener(() => checkEmpty());
    newPasswordController.addListener(() => checkEmpty());
    confirmPasswordController.addListener(() => checkEmpty());
    confirmPasswordController.addListener(() {
      context.read<ChangePasswordBloc>().add(TextChangeEvent());
    });
    newPasswordController.addListener(() {
      context.read<ChangePasswordBloc>().add(TextChangeEvent());
    });
    super.initState();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void checkEmpty() {
    if (oldPasswordController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      context
          .read<ChangePasswordBloc>()
          .add(ShowChangeButtonEvent(isContinue: true));
    } else {
      context
          .read<ChangePasswordBloc>()
          .add(ShowChangeButtonEvent(isContinue: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccessState) {
          customToast(
              context, "change_password_successfully".translate(context));
          Navigator.pop(context);
          Navigator.pop(context);
        }
        if (state is ChangePasswordErrorState) {
          customToast(context, state.status);
          Navigator.pop(context);
        }
        if (state is ChangePasswordLoadingState) {
          loadingAnimation(context);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "change_password".translate(context),
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text("password_needs_characters".translate(context)),
          const SizedBox(height: 10),
          passwordInput(),
          const Spacer(),
          changePasswordButton(),
          const SizedBox(height: 10)
        ],
      ),
    );
  }

  Widget passwordInput() {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) =>
          current is HidePasswordState || current is TextChangeState,
      builder: (context, state) {
        return Column(
          children: [
            CustomPasswordInput(
              controller: oldPasswordController,
              hint: "enter_old_password".translate(context),
              hide: state is HidePasswordState ? state.isHide : hide,
              onPress: () => changeHide(),
            ),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomPasswordInput(
                    controller: newPasswordController,
                    hint: "enter_new_password".translate(context),
                    hide: state is HidePasswordState ? state.isHide : hide,
                    onPress: () => changeHide(),
                  ),
                  const SizedBox(height: 10),
                  CustomPasswordInput(
                    controller: confirmPasswordController,
                    confirmPassword: newPasswordController.text,
                    hint: "confirm_password".translate(context),
                    hide: state is HidePasswordState ? state.isHide : hide,
                    onPress: () => changeHide(),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  void changeHide() {
    context.read<ChangePasswordBloc>().add(HidePasswordEvent(isHide: !hide));
    hide = !hide;
  }

  Widget changePasswordButton() {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      buildWhen: (previous, current) => current is ContinueState,
      builder: (context, state) {
        return customButton(
          text: "change_password".translate(context),
          isOnPress: state is ContinueState ? state.isContinue : false,
          onPress: () {
            if (_formKey.currentState!.validate()) {
              var bytes = utf8.encode(oldPasswordController.text);
              var digest = sha256.convert(bytes);
              if (digest.toString() == widget.user.password) {
                bytes = utf8.encode(newPasswordController.text);
                digest = sha256.convert(bytes);
                context.read<ChangePasswordBloc>().add(ClickChangePasswordEvent(
                    widget.user.copyWith(password: digest.toString())));
              } else {
                customToast(
                    context, "old_password_is_not_correct".translate(context));
              }
            }
          },
        );
      },
    );
  }
}
