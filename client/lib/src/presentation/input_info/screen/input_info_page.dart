import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/input_info/bloc/input_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../core/utils/enum/enums.dart';
import '../../../data/models/user.dart';
import '../../login/screen/login_page.dart';
import '../../login/widgets/custom_button.dart';
import '../../profile/widgets/custom_picker_widget.dart';
import '../../profile/widgets/modal_gender.dart';
import '../../signup/widgets/custom_text_input.dart';
import '../bloc/input_info_event.dart';
import '../bloc/input_info_state.dart';

class InputInfoPage extends StatelessWidget {
  const InputInfoPage({Key? key, required this.account}) : super(key: key);

  final GoogleSignInAccount account;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgCreamColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: BlocProvider(
            create: (context) => InputInfoBloc(),
            child: InputInfoView(account: account),
          ),
        ),
      ),
    );
  }
}

class InputInfoView extends StatefulWidget {
  const InputInfoView({Key? key, required this.account}) : super(key: key);

  final GoogleSignInAccount account;

  @override
  State<InputInfoView> createState() => _InputInfoViewState();
}

class _InputInfoViewState extends State<InputInfoView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isMale = true;
  DateTime? selectedDate;

  @override
  void initState() {
    emailController.text = widget.account.email;
    nameController.text = widget.account.displayName.toString();
    phoneController.addListener(() => checkEmpty());
    nameController.addListener(() => checkEmpty());
    super.initState();
  }

  void checkEmpty() {
    if (phoneController.text.isNotEmpty && nameController.text.isNotEmpty) {
      context.read<InputInfoBloc>().add(ClickSubmitEvent(isContinue: true));
    } else {
      context.read<InputInfoBloc>().add(ClickSubmitEvent(isContinue: false));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InputInfoBloc, InputInfoState>(
      listener: (context, state) {
        if (state is SubmitSuccessState) {
          Fluttertoast.showToast(msg: "Đăng ký thành công");
          Navigator.of(context).pushReplacement(createRoute(
            screen: const LoginPage(),
            begin: const Offset(0, 1),
          ));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              inputInfoTitle(),
              const SizedBox(height: 20),
              const SizedBox(height: 10),
              registerInfo(),
              const SizedBox(height: 20),
              submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputInfoTitle() {
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
      ],
    );
  }

  Widget gender() {
    return BlocBuilder<InputInfoBloc, InputInfoState>(
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
              context.read<InputInfoBloc>().add(ChangeGenderEvent());
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  Widget birthday() {
    return BlocBuilder<InputInfoBloc, InputInfoState>(
      buildWhen: (previous, current) => current is ChangeBirthdayState,
      builder: (context, state) {
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
          checkEdit: false,
          typeInput: const [TypeInput.email],
          hint: "Email",
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  Widget submitButton() {
    return BlocBuilder<InputInfoBloc, InputInfoState>(
      buildWhen: (previous, current) => current is ContinueState,
      builder: (context, state) {
        return customButton(
          text: "continue".translate(context),
          isOnPress: state is ContinueState ? state.isContinue : false,
          onPress: () {
            if (_formKey.currentState!.validate()) {
              context.read<InputInfoBloc>().add(SubmitEvent(
                  account: widget.account,
                  user: User(
                    username: emailController.text,
                    displayName: nameController.text,
                    isMale: isMale,
                    email: emailController.text,
                    phoneNumber: phoneController.text,
                    password: "",
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
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      if (mounted) context.read<InputInfoBloc>().add(ChangeBirthdayEvent());
    }
  }
}
