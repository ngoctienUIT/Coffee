import 'package:coffee/injection.dart';
import 'package:coffee/src/core/request/input_info_request/input_info_request.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:coffee/src/presentation/coupon/widgets/app_bar_general.dart';
import 'package:coffee/src/presentation/input_info/bloc/input_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
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
      appBar: AppBarGeneral(
        elevation: 0,
        backgroundColor: Colors.transparent,
        onBack: () => GoogleSignIn().signOut(),
      ),
      body: WillPopScope(
        onWillPop: () {
          GoogleSignIn().signOut();
          return Future.value(true);
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BlocProvider<InputInfoBloc>(
              create: (context) => getIt<InputInfoBloc>(),
              child: InputInfoView(account: account),
            ),
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
    if (phoneController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        selectedDate != null) {
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
          customToast(context, AppLocalizations.of(context).signUpSuccess);
          Navigator.of(context).pushReplacement(createRoute(
            screen: const LoginPage(),
            begin: const Offset(0, 1),
          ));
        }
        if (state is SubmitErrorState) customToast(context, state.status);
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
          AppLocalizations.of(context).startJourney,
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
          text: isMale
              ? AppLocalizations.of(context).male
              : AppLocalizations.of(context).female,
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
        checkEmpty();
        return CustomPickerWidget(
          checkEdit: true,
          text: selectedDate == null
              ? AppLocalizations.of(context).birthday
              : DateFormat("dd/MM/yyyy").format(selectedDate!),
          onPress: () => selectDate(),
        );
      },
    );
  }

  Widget registerName() {
    return CustomTextInput(
      controller: nameController,
      hint: AppLocalizations.of(context).name,
      validator: (value) {
        if (value!.isEmpty) {
          return "${AppLocalizations.of(context).pleaseEnter} ${AppLocalizations.of(context).name}";
        }
        return null;
      },
    );
  }

  Widget registerContact() {
    return Column(
      children: [
        CustomTextInput(
          controller: phoneController,
          hint: AppLocalizations.of(context).phoneNumber,
          validator: (value) {
            if (!value!.isValidPhone() && value.isOnlyNumbers() ||
                value.isEmpty) {
              return AppLocalizations.of(context).pleaseEnterPhoneNumber;
            }
            return null;
          },
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 10),
        CustomTextInput(
          controller: emailController,
          checkEdit: false,
          validator: (value) {
            if (!value!.isValidEmail() && !value.isOnlyNumbers() ||
                value.isEmpty) {
              return AppLocalizations.of(context).pleaseEnterEmail;
            }
            return null;
          },
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
          text: AppLocalizations.of(context).continue1,
          isOnPress: state is ContinueState ? state.isContinue : false,
          onPress: () {
            if (_formKey.currentState!.validate()) {
              context.read<InputInfoBloc>().add(SubmitEvent(InputInfoRequest(
                  account: widget.account,
                  user: User(
                    username: emailController.text,
                    displayName: nameController.text,
                    isMale: isMale,
                    email: emailController.text,
                    phoneNumber: phoneController.text,
                    password: "",
                    birthOfDate: DateFormat("dd/MM/yyyy").format(selectedDate!),
                  ))));
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
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      if (mounted) context.read<InputInfoBloc>().add(ChangeBirthdayEvent());
    }
  }
}
