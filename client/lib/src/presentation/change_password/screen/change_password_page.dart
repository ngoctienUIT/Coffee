import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/data/models/user.dart';
import 'package:coffee/src/presentation/change_password/bloc/change_password_bloc.dart';
import 'package:coffee/src/presentation/change_password/bloc/change_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../domain/entities/user/user_response.dart';
import '../../login/widgets/custom_button.dart';
import '../../login/widgets/custom_password_input.dart';
import '../../voucher/widgets/app_bar_general.dart';
import '../bloc/change_password_event.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key, required this.user}) : super(key: key);

  final UserResponse user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordBloc(),
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

  final UserResponse user;

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
          Navigator.pop(context);
        }
      },
      child: Form(
        key: _formKey,
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
            print(newPasswordController.text);
            print(confirmPasswordController.text);
            if (_formKey.currentState!.validate()) {
              if (oldPasswordController.text == widget.user.hashedPassword) {
                context.read<ChangePasswordBloc>().add(ClickChangePasswordEvent(
                    User.fromUserResponse(widget.user)
                        .copyWith(password: newPasswordController.text)));
              } else {
                Fluttertoast.showToast(msg: "Mật khẩu chưa chính xác");
              }
            }
          },
        );
      },
    );
  }
}
