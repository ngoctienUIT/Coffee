import 'package:coffee_admin/injection.dart';
import 'package:coffee_admin/src/core/function/custom_toast.dart';
import 'package:coffee_admin/src/core/function/loading_animation.dart';
import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:coffee_admin/src/presentation/input_pin/bloc/input_pin_bloc.dart';
import 'package:coffee_admin/src/presentation/input_pin/bloc/input_pin_event.dart';
import 'package:coffee_admin/src/presentation/input_pin/bloc/input_pin_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../core/utils/enum/enums.dart';
import '../../forgot_password/widgets/app_bar_general.dart';
import '../../login/widgets/custom_button.dart';
import '../../new_password/screen/new_password_page.dart';
import '../../signup/widgets/custom_text_input.dart';

class InputPinPage extends StatelessWidget {
  const InputPinPage({Key? key, required this.resetCredential})
      : super(key: key);

  final String resetCredential;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InputPinBloc>(
      create: (context) => getIt<InputPinBloc>(),
      child: InputPinView(resetCredential: resetCredential),
    );
  }
}

class InputPinView extends StatefulWidget {
  const InputPinView({Key? key, required this.resetCredential})
      : super(key: key);

  final String resetCredential;

  @override
  State<InputPinView> createState() => _InputPinViewState();
}

class _InputPinViewState extends State<InputPinView> {
  TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller.addListener(() {
      if (controller.text.length == 6) {
        context.read<InputPinBloc>().add(ShowButtonEvent(true));
      } else {
        context.read<InputPinBloc>().add(ShowButtonEvent(false));
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
    return BlocListener<InputPinBloc, InputPinState>(
      listener: (context, state) {
        if (state is LoadingState) loadingAnimation(context);
        if (state is ErrorState) {
          customToast(context, state.error);
          Navigator.pop(context);
        }
        if (state is SuccessState) {
          Navigator.pop(context);
          if (state.check) {
            Navigator.of(context).pushReplacement(createRoute(
              screen: NewPasswordPage(resetCredential: widget.resetCredential),
              begin: const Offset(1, 0),
            ));
          } else {
            customToast(context, "PIN_code_is_not_correct".translate(context));
          }
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
                  Text("enter_the_PIN_code".translate(context)),
                  const SizedBox(height: 20),
                  CustomTextInput(
                    controller: controller,
                    hint: "PIN",
                    maxLength: 6,
                    typeInput: const [TypeInput.text],
                  ),
                  const SizedBox(height: 20),
                  Text("enter_PIN_that_sent_your_email".translate(context)),
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
    return BlocBuilder<InputPinBloc, InputPinState>(
      buildWhen: (previous, current) => current is ContinueState,
      builder: (context, state) {
        return customButton(
          text: "continue".translate(context),
          onPress: () {
            if (_formKey.currentState!.validate()) {
              context
                  .read<InputPinBloc>()
                  .add(SendEvent(widget.resetCredential, controller.text));
            }
          },
          isOnPress: state is ContinueState ? state.isContinue : false,
        );
      },
    );
  }
}
