import 'dart:math';

import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:coffee_admin/src/presentation/add_tag/screen/add_tag_page.dart';
import 'package:coffee_admin/src/presentation/order/widgets/item_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../core/widgets/custom_alert_dialog.dart';
import '../../../data/models/tag.dart';
import '../../forgot_password/widgets/app_bar_general.dart';
import '../../login/widgets/custom_button.dart';
import '../bloc/tag_bloc.dart';
import '../bloc/tag_event.dart';
import '../bloc/tag_state.dart';

class TagPage extends StatelessWidget {
  const TagPage({Key? key, this.onPick, this.listTag}) : super(key: key);

  final Function(List<Tag> listTag)? onPick;
  final List<String>? listTag;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TagBloc()..add(FetchData()),
      child: TagView(onPick: onPick, listTag: listTag),
    );
  }
}

class TagView extends StatefulWidget {
  const TagView({Key? key, this.onPick, this.listTag}) : super(key: key);

  final Function(List<Tag> listTag)? onPick;
  final List<String>? listTag;

  @override
  State<TagView> createState() => _TagViewState();
}

class _TagViewState extends State<TagView> {
  List<Tag> listTag = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: const AppBarGeneral(title: "Tag", elevation: 0),
      body: buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(createRoute(
            screen: AddTagPage(
              onChange: () => context.read<TagBloc>().add(UpdateData()),
            ),
            begin: const Offset(0, 1),
          ));
        },
        backgroundColor: AppColors.statusBarColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildBody() {
    return BlocConsumer<TagBloc, TagState>(
      listener: (context, state) {
        if (state is TagError) {
          customToast(context, state.message.toString());
        }
      },
      buildWhen: (previous, current) => current is! PickState,
      builder: (context, state) {
        if (state is TagLoaded) {
          listTag = state.listTag.map((e) => Tag.fromTagResponse(e)).toList();
          if (widget.listTag != null) {
            for (int i = 0; i < listTag.length; i++) {
              if (widget.listTag!.contains(listTag[i].tagId)) {
                listTag[i].isCheck = true;
              }
            }
          }
          return widget.onPick == null
              ? RefreshIndicator(
                  onRefresh: () async {
                    context.read<TagBloc>().add(FetchData());
                  },
                  child: listTagWidget(listTag),
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      listTagWidget(listTag),
                      buttonSave(),
                      const SizedBox(height: 80),
                    ],
                  ),
                );
        }
        return _buildLoading();
      },
    );
  }

  Widget buttonSave() {
    return BlocBuilder<TagBloc, TagState>(
      buildWhen: (previous, current) => current is PickState,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: customButton(
            text: "save".translate(context),
            isOnPress: true,
            onPress: () {
              widget.onPick!(
                  listTag.where((element) => element.isCheck).toList());
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  Widget listTagWidget(List<Tag> listTag) {
    return ListView.builder(
      physics: widget.onPick == null
          ? const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            )
          : const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(10, 10, 10, widget.onPick == null ? 60 : 10),
      shrinkWrap: widget.onPick == null ? false : true,
      itemCount: listTag.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: widget.onPick != null
              ? Row(
                  children: [
                    BlocBuilder<TagBloc, TagState>(
                      buildWhen: (previous, current) => current is PickState,
                      builder: (context, state) {
                        return Checkbox(
                          value: listTag[index].isCheck,
                          onChanged: (value) {
                            listTag[index].isCheck = value!;
                            context.read<TagBloc>().add(PickEvent());
                          },
                        );
                      },
                    ),
                    Expanded(child: tagItem(listTag[index])),
                  ],
                )
              : Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.3,
                    children: [
                      SlidableAction(
                        onPressed: (_) {
                          Navigator.of(context).push(createRoute(
                            screen: AddTagPage(
                              tag: listTag[index],
                              onChange: () {
                                context.read<TagBloc>().add(UpdateData());
                              },
                            ),
                            begin: const Offset(0, 1),
                          ));
                        },
                        backgroundColor: AppColors.statusBarColor,
                        foregroundColor: const Color.fromRGBO(231, 231, 231, 1),
                        icon: FontAwesomeIcons.penToSquare,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      SlidableAction(
                        onPressed: (_) {
                          _showAlertDialog(context, () {
                            context
                                .read<TagBloc>()
                                .add(DeleteEvent(listTag[index].tagId!));
                          });
                        },
                        backgroundColor: AppColors.statusBarColor,
                        foregroundColor: const Color.fromRGBO(231, 231, 231, 1),
                        icon: FontAwesomeIcons.trash,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ],
                  ),
                  child: tagItem(listTag[index]),
                ),
        );
      },
    );
  }

  Widget tagItem(Tag tag) {
    String color = "FF${tag.tagColorCode!.split("#").last}";
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: double.infinity),
            Text(
              tag.tagName!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.statusBarColor,
              ),
            ),
            const SizedBox(height: 5),
            if (tag.tagDescription != null)
              Text(
                tag.tagDescription!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.statusBarColor,
                ),
              ),
            const SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                color: Color(int.parse(color, radix: 16)),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.all(5),
              child: Text(
                tag.tagColorCode!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(10, 10, 10, widget.onPick == null ? 60 : 10),
      itemCount: 10,
      itemBuilder: (context, index) {
        return widget.onPick != null
            ? Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                  ),
                  Expanded(child: tagItemLoading()),
                ],
              )
            : tagItemLoading();
      },
    );
  }

  Widget tagItemLoading() {
    var rng = Random();
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            itemLoading(20, rng.nextDouble() * 100 + 100, 10),
            const SizedBox(height: 5),
            itemLoading(15, rng.nextDouble() * 150 + 100, 10),
            const SizedBox(height: 5),
            itemLoading(25, 100, 20),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  Future _showAlertDialog(BuildContext context, VoidCallback onOK) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return customAlertDialog(
          context: context,
          title: 'remove_tag'.translate(context),
          content:
              'are_you_sure_you_want_to_remove_this_tag'.translate(context),
          onOK: onOK,
        );
      },
    );
  }
}
