import 'package:coffee_admin/injection.dart';
import 'package:coffee_admin/src/core/function/loading_animation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:coffee_admin/src/data/models/tag.dart';
import 'package:coffee_admin/src/presentation/add_tag/bloc/add_tag_bloc.dart';
import 'package:coffee_admin/src/presentation/add_tag/bloc/add_tag_event.dart';
import 'package:coffee_admin/src/presentation/add_tag/bloc/add_tag_state.dart';
import 'package:coffee_admin/src/presentation/forgot_password/widgets/app_bar_general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../core/function/custom_toast.dart';
import '../../login/widgets/custom_button.dart';
import '../../product/widgets/description_line.dart';
import '../../profile/widgets/custom_picker_widget.dart';
import '../../signup/widgets/custom_text_input.dart';

class AddTagPage extends StatelessWidget {
  const AddTagPage({Key? key, required this.onChange, this.tag})
      : super(key: key);

  final VoidCallback onChange;
  final Tag? tag;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddTagBloc>(),
      child: Scaffold(
        appBar: AppBarGeneral(
            elevation: 0, title: AppLocalizations.of(context)!.addTags),
        body: AddTagView(onChange: onChange, tag: tag),
      ),
    );
  }
}

class AddTagView extends StatefulWidget {
  const AddTagView({Key? key, required this.onChange, this.tag})
      : super(key: key);

  final VoidCallback onChange;
  final Tag? tag;

  @override
  State<AddTagView> createState() => _AddTagViewState();
}

class _AddTagViewState extends State<AddTagView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? textColor;

  @override
  void initState() {
    if (widget.tag != null) {
      nameController.text = widget.tag!.tagName!;
      descriptionController.text = widget.tag!.tagDescription ?? "";
      textColor = widget.tag!.tagColorCode!;
    }
    nameController.addListener(() => checkEmpty());
    descriptionController.addListener(() => checkEmpty());
    super.initState();
  }

  void checkEmpty() {
    if (nameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        textColor != null) {
      context.read<AddTagBloc>().add(SaveButtonEvent(true));
    } else {
      context.read<AddTagBloc>().add(SaveButtonEvent(false));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTagBloc, AddTagState>(
      listener: (context, state) {
        if (state is AddTagSuccessState) {
          widget.onChange();
          if (widget.tag == null) {
            customToast(
                context, AppLocalizations.of(context)!.addSuccessfulTag);
          } else {
            customToast(
                context, AppLocalizations.of(context)!.updateSuccessful);
          }
          Navigator.pop(context);
          Navigator.pop(context);
        }
        if (state is AddTagLoadingState) {
          loadingAnimation(context);
        }
        if (state is AddTagErrorState) {
          customToast(context, state.status);
          Navigator.pop(context);
        }
        if (state is ChangeColorState) {
          checkEmpty();
        }
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
              descriptionLine(text: AppLocalizations.of(context)!.name),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: nameController,
                hint: AppLocalizations.of(context)!.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.name}";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              descriptionLine(text: AppLocalizations.of(context)!.description),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: descriptionController,
                hint: AppLocalizations.of(context)!.description,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.description}";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              descriptionLine(text: AppLocalizations.of(context)!.color),
              const SizedBox(height: 10),
              pickColor(),
              const SizedBox(height: 10),
              saveButton(),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget pickColor() {
    return BlocBuilder<AddTagBloc, AddTagState>(
      buildWhen: (previous, current) => current is ChangeColorState,
      builder: (context, state) {
        checkEmpty();
        return CustomPickerWidget(
          checkEdit: true,
          text: textColor ?? "",
          onPress: () => showPickColor(),
        );
      },
    );
  }

  Color pickerColor = const Color(0xff443a49);

  void showPickColor() {
    BuildContext myContext = context;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.pickAColor),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (value) => pickerColor = value,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.ok),
              onPressed: () {
                textColor =
                    "#${pickerColor.toString().substring(10, 16).toUpperCase()}";
                myContext.read<AddTagBloc>().add(ChangeColorEvent());
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget saveButton() {
    return BlocBuilder<AddTagBloc, AddTagState>(
      buildWhen: (previous, current) => current is SaveButtonState,
      builder: (context, state) {
        return customButton(
          text: AppLocalizations.of(context)!.save,
          isOnPress: state is SaveButtonState ? state.isContinue : false,
          onPress: () {
            if (_formKey.currentState!.validate()) {
              if (widget.tag == null) {
                context.read<AddTagBloc>().add(CreateTagEvent(Tag(
                      tagName: nameController.text,
                      tagDescription: descriptionController.text,
                      tagColorCode: textColor,
                    )));
              } else {
                context.read<AddTagBloc>().add(UpdateTagEvent(Tag(
                      tagId: widget.tag!.tagId,
                      tagName: nameController.text,
                      tagDescription: descriptionController.text,
                      tagColorCode: textColor,
                    )));
              }
            }
          },
        );
      },
    );
  }
}
