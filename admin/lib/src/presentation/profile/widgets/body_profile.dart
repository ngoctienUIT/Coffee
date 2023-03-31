import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constants/constants.dart';
import '../../../core/utils/enum/enums.dart';
import '../../../domain/entities/user/user_response.dart';
import '../../product/widgets/description_line.dart';
import '../../signup/widgets/custom_text_input.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import 'custom_picker_widget.dart';
import 'modal_gender.dart';

class BodyProfilePage extends StatefulWidget {
  const BodyProfilePage({Key? key, required this.user}) : super(key: key);

  final UserResponse user;

  @override
  State<BodyProfilePage> createState() => _BodyProfilePageState();
}

class _BodyProfilePageState extends State<BodyProfilePage> {
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  bool isEdit = false;
  bool isMale = true;

  @override
  void initState() {
    surnameController.text = widget.user.displayName;
    nameController.text = widget.user.displayName;
    phoneController.text = widget.user.phoneNumber;
    emailController.text = widget.user.email;
    isMale = widget.user.isMale;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        color: AppColors.bgColor,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is EditProfileSate) isEdit = state.isEdit;
              return body();
            },
          ),
        ),
      ),
    );
  }

  void onSave() {
    if (isEdit) {
      if (_formKey.currentState!.validate()) {
        context.read<ProfileBloc>().add(EditProfileEvent(isEdit: !isEdit));
        context.read<ProfileBloc>().add(SaveProfileEvent());
      }
    } else {
      context.read<ProfileBloc>().add(EditProfileEvent(isEdit: !isEdit));
    }
  }

  Widget body() {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            descriptionLine(text: "general_info".translate(context)),
            const Spacer(),
            TextButton(
              onPressed: onSave,
              child: Text(
                (isEdit ? "save" : "edit").translate(context),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: CustomTextInput(
                controller: surnameController,
                hint: "surname".translate(context),
                typeInput: const [TypeInput.text],
                checkEdit: isEdit,
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
                checkEdit: isEdit,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        CustomPickerWidget(
          checkEdit: isEdit,
          text:
              isMale ? "male".translate(context) : "female".translate(context),
          onPress: () => showMyBottomSheet(
            context: context,
            isMale: isMale,
            onPress: (isMale) {
              Navigator.pop(context);
              setState(() => this.isMale = isMale);
            },
          ),
        ),
        const SizedBox(height: 10),
        CustomPickerWidget(
          checkEdit: isEdit,
          text: "birthday".translate(context),
          onPress: () => selectDate(),
        ),
        const SizedBox(height: 10),
        descriptionLine(text: "phone_number".translate(context)),
        const SizedBox(height: 10),
        CustomTextInput(
          controller: phoneController,
          hint: "phone_number".translate(context),
          typeInput: const [TypeInput.phone],
          checkEdit: isEdit,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 10),
        descriptionLine(text: "Email"),
        const SizedBox(height: 10),
        CustomTextInput(
          controller: emailController,
          typeInput: const [TypeInput.email],
          hint: "Email",
          checkEdit: isEdit,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 10),
        descriptionLine(text: "affiliate_account".translate(context)),
      ],
    );
  }

  void selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }
}
