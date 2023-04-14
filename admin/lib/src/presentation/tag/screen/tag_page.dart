import 'dart:math';

import 'package:coffee_admin/src/presentation/add_tag/screen/add_tag_page.dart';
import 'package:coffee_admin/src/presentation/order/widgets/item_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../data/models/tag.dart';
import '../../../domain/repositories/tag/tag_response.dart';
import '../../forgot_password/widgets/app_bar_general.dart';
import '../bloc/tag_bloc.dart';
import '../bloc/tag_event.dart';
import '../bloc/tag_state.dart';

class TagPage extends StatelessWidget {
  const TagPage({Key? key, this.onPick}) : super(key: key);

  final Function(TagResponse tag)? onPick;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TagBloc()..add(FetchData()),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: const AppBarGeneral(title: "Tags", elevation: 0),
        body: TagView(onPick: onPick),
        floatingActionButton: BlocBuilder<TagBloc, TagState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(createRoute(
                  screen: AddTagPage(
                    onChange: () => context.read<TagBloc>().add(FetchData()),
                  ),
                  begin: const Offset(0, 1),
                ));
              },
              backgroundColor: AppColors.statusBarColor,
              child: const Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }
}

class TagView extends StatelessWidget {
  const TagView({Key? key, this.onPick}) : super(key: key);

  final Function(TagResponse catalogue)? onPick;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagBloc, TagState>(
      builder: (context, state) {
        if (state is TagLoaded) {
          final listTag = state.listTag;
          return RefreshIndicator(
            onRefresh: () async {
              context.read<TagBloc>().add(FetchData());
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 60),
              itemCount: listTag.length,
              itemBuilder: (context, index) {
                final myContext = context;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: InkWell(
                    onTap: onPick != null
                        ? () {
                            onPick!(listTag[index]);
                            Navigator.pop(context);
                          }
                        : null,
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        extentRatio: 0.3,
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              Navigator.of(context).push(createRoute(
                                screen: AddTagPage(
                                  tag: Tag.fromTagResponse(listTag[index]),
                                  onChange: () {
                                    myContext.read<TagBloc>().add(FetchData());
                                  },
                                ),
                                begin: const Offset(0, 1),
                              ));
                            },
                            backgroundColor: AppColors.statusBarColor,
                            foregroundColor:
                                const Color.fromRGBO(231, 231, 231, 1),
                            icon: FontAwesomeIcons.penToSquare,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              context
                                  .read<TagBloc>()
                                  .add(DeleteEvent(listTag[index].tagId));
                            },
                            backgroundColor: AppColors.statusBarColor,
                            foregroundColor:
                                const Color.fromRGBO(231, 231, 231, 1),
                            icon: FontAwesomeIcons.trash,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ],
                      ),
                      child: tagItem(listTag[index]),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return _buildLoading();
      },
    );
  }

  Widget tagItem(TagResponse tag) {
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
    var rng = Random();
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 60),
      itemCount: 10,
      itemBuilder: (context, index) {
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
      },
    );
  }
}
