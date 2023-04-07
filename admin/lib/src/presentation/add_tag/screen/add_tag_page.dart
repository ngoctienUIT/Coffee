import 'package:coffee_admin/src/core/function/loading_animation.dart';
import 'package:coffee_admin/src/data/models/tag.dart';
import 'package:coffee_admin/src/presentation/add_tag/bloc/add_tag_bloc.dart';
import 'package:coffee_admin/src/presentation/add_tag/bloc/add_tag_event.dart';
import 'package:coffee_admin/src/presentation/add_tag/bloc/add_tag_state.dart';
import 'package:coffee_admin/src/presentation/forgot_password/widgets/app_bar_general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../login/widgets/custom_button.dart';
import '../../product/widgets/description_line.dart';
import '../../signup/widgets/custom_text_input.dart';

class AddTagPage extends StatelessWidget {
  const AddTagPage({Key? key, required this.onChange, this.tag})
      : super(key: key);

  final VoidCallback onChange;
  final Tag? tag;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTagBloc(),
      child: Scaffold(
        appBar: const AppBarGeneral(elevation: 0, title: "Thêm tag"),
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
  TextEditingController colorController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.tag != null) {
      nameController.text = widget.tag!.tagName!;
      descriptionController.text = widget.tag!.tagDescription ?? "";
      colorController.text = widget.tag!.tagColorCode!;
    }
    nameController.addListener(() => checkEmpty());
    descriptionController.addListener(() => checkEmpty());
    colorController.addListener(() => checkEmpty());
    super.initState();
  }

  void checkEmpty() {
    if (nameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        colorController.text.isNotEmpty) {
      context.read<AddTagBloc>().add(SaveButtonEvent(true));
    } else {
      context.read<AddTagBloc>().add(SaveButtonEvent(false));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTagBloc, AddTagState>(
      listener: (context, state) {
        if (state is AddTagSuccessState) {
          widget.onChange();
          Fluttertoast.showToast(msg: "Thêm tag thành công");
          Navigator.pop(context);
          Navigator.pop(context);
        }
        if (state is AddTagLoadingState) {
          loadingAnimation(context);
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
              descriptionLine(text: "Tên"),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: nameController,
                hint: "Tên",
                title: "Tên",
              ),
              const SizedBox(height: 10),
              descriptionLine(text: "Mô tả"),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: descriptionController,
                hint: "Mô tả",
                title: "Mô tả",
              ),
              const SizedBox(height: 10),
              descriptionLine(text: "Màu sắc"),
              const SizedBox(height: 10),
              CustomTextInput(
                controller: colorController,
                hint: "Màu sắc",
                title: "Màu sắc",
              ),
              const SizedBox(height: 10),
              saveButton(),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget saveButton() {
    return BlocBuilder<AddTagBloc, AddTagState>(
      buildWhen: (previous, current) => current is SaveButtonState,
      builder: (context, state) {
        return customButton(
            text: "Lưu",
            isOnPress: state is SaveButtonState ? state.isContinue : false,
            onPress: () {
              if (_formKey.currentState!.validate()) {
                if (widget.tag == null) {
                  context.read<AddTagBloc>().add(CreateTagEvent(Tag(
                        tagName: nameController.text,
                        tagDescription: descriptionController.text,
                        tagColorCode: colorController.text,
                      )));
                } else {
                  context.read<AddTagBloc>().add(UpdateTagEvent(Tag(
                        tagId: widget.tag!.tagId,
                        tagName: nameController.text,
                        tagDescription: descriptionController.text,
                        tagColorCode: colorController.text,
                      )));
                }
              }
            });
      },
    );
  }
}
