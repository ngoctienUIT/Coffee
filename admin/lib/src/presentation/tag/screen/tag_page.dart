import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constants/constants.dart';
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
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: const AppBarGeneral(title: "Tags", elevation: 0),
      body: BlocProvider(
        create: (context) => TagBloc()..add(FetchData()),
        child: TagView(onPick: onPick),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.of(context).push(createRoute(
          //   screen: const AddProductPage(),
          //   begin: const Offset(0, 1),
          // ));
        },
        backgroundColor: AppColors.statusBarColor,
        child: const Icon(Icons.add),
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
        if (state is InitState || state is TagLoading) {
          return _buildLoading();
        }
        if (state is TagError) {
          return Center(child: Text(state.message!));
        }
        if (state is TagLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<TagBloc>().add(FetchData());
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.all(10),
              itemCount: state.listTag.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: InkWell(
                    onTap: onPick != null
                        ? () {
                            onPick!(state.listTag[index]);
                            Navigator.pop(context);
                          }
                        : null,
                    child: tagItem(state.listTag[index]),
                  ),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget tagItem(TagResponse tag) {
    String color = "FF${tag.tagColorCode!.split("#").last}";
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tag.tagName!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.statusBarColor,
              ),
            ),
            if (tag.tagDescription != null)
              Text(
                tag.tagDescription!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.statusBarColor,
                ),
              ),
            Container(
              decoration: BoxDecoration(
                  color: Color(int.parse(color, radix: 16)),
                  borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.all(5),
              child: Text(
                tag.tagColorCode!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
