import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/domain/repositories/store/store_response.dart';
import 'package:coffee/src/presentation/main/bloc/main_state.dart';
import 'package:coffee/src/presentation/signup/widgets/custom_text_input.dart';
import 'package:coffee/src/presentation/store/bloc/store_bloc.dart';
import 'package:coffee/src/presentation/store/bloc/store_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/utils/constants/constants.dart';
import '../../activity/widgets/custom_app_bar.dart';
import '../../main/bloc/main_bloc.dart';
import '../../main/bloc/main_event.dart';
import '../bloc/store_event.dart';
import '../widgets/bottom_sheet.dart';
import '../widgets/item_loading.dart';

class StorePage extends StatelessWidget {
  const StorePage({
    Key? key,
    this.onPress,
    required this.isPick,
    this.onChange,
    required this.check,
  }) : super(key: key);

  final Function(StoreResponse store)? onPress;
  final VoidCallback? onChange;
  final bool isPick;
  final bool check;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StoreBloc>(
      create: (_) => StoreBloc()..add(FetchData()),
      child: StoreView(
        onPress: onPress,
        isPick: isPick,
        onChange: onChange,
        check: check,
      ),
    );
  }
}

class StoreView extends StatefulWidget {
  const StoreView({
    Key? key,
    this.onPress,
    required this.isPick,
    this.onChange,
    required this.check,
  }) : super(key: key);

  final Function(StoreResponse store)? onPress;
  final VoidCallback? onChange;
  final bool isPick;
  final bool check;

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView>
    with AutomaticKeepAliveClientMixin {
  TextEditingController searchStoreController = TextEditingController();
  String? storeID;

  @override
  void dispose() {
    searchStoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.check
        ? BlocListener<MainBloc, MainState>(
            listener: (_, state) {
              if (state is ChangeStoreState) {
                print("Change store from store page");
                context.read<StoreBloc>().add(FetchData());
              }
            },
            child: buildBody(),
          )
        : buildBody();
  }

  Widget buildBody() {
    return BlocListener<StoreBloc, StoreState>(
      listener: (context, state) {
        if (state is StoreError) {
          customToast(context, state.message.toString());
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: CustomAppBar(
          elevation: 0,
          isPick: widget.isPick,
          title: "store".translate(context),
          onChange: () {
            context.read<MainBloc>().add(ChangeCartHomeEvent());
            context.read<MainBloc>().add(ChangeCartOrderEvent());
          },
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              headerStore(),
              const SizedBox(height: 10),
              Expanded(child: bodyStore()),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerStore() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CustomTextInput(
        onChanged: (value) {
          context.read<StoreBloc>().add(SearchStore(storeName: value));
        },
        controller: searchStoreController,
        hint: "address_search".translate(context),
        radius: 90,
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        textInputAction: TextInputAction.search,
        textStyle: const TextStyle(fontSize: 13),
        suffixIcon: const Icon(
          FontAwesomeIcons.magnifyingGlass,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget bodyStore() {
    return BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        print(state);
        if (state is StoreLoaded) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: state.listStore.length,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => showStoreBottomSheet(
                  context,
                  state.listStore[index],
                  () {
                    if (widget.onPress != null) {
                      widget.onPress!(state.listStore[index]);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      SharedPreferences.getInstance().then((value) {
                        value.setString(
                            "storeID", state.listStore[index].storeId);
                        // context.read<StoreBloc>().add(
                        //     SearchStore(storeName: searchStoreController.text));
                        context.read<StoreBloc>().add(UpdateStoreOrder());
                        Navigator.pop(context);
                        if (widget.onChange != null) widget.onChange!();
                      });
                    }
                  },
                ),
                child: itemStore(state.listStore[index], state.id),
              );
            },
          );
        }
        return _buildLoading();
      },
    );
  }

  Widget _buildLoading() {
    var rng = Random();
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 10,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      itemBuilder: (context, index) {
        return Card(
          child: Row(
            children: [
              const SizedBox(width: 10),
              itemLoading(100, 100, 0),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    itemLoading(20, double.infinity, 10),
                    const SizedBox(height: 5),
                    itemLoading(20, rng.nextDouble() * 150 + 100, 10),
                    const SizedBox(height: 5),
                    itemLoading(15, double.infinity, 10),
                    const SizedBox(height: 5),
                    itemLoading(15, rng.nextDouble() * 150 + 100, 10),
                    const SizedBox(height: 5),
                    itemLoading(15, 200, 10),
                    const SizedBox(height: 5),
                    itemLoading(15, 200, 10),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        );
      },
    );
  }

  Widget itemStore(StoreResponse store, String id) {
    return Stack(
      children: [
        Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                CachedNetworkImage(
                  height: 100,
                  width: 100,
                  fit: BoxFit.fitHeight,
                  imageUrl:
                      "https://www.highlandscoffee.com.vn/vnt_upload/news/02_2020/83739091_2845644318849727_1748210367038750720_o_1.png",
                  placeholder: (context, url) => itemLoading(100, 100, 0),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(width: 10),
                Expanded(child: infoStore(store))
              ],
            ),
          ),
        ),
        if (store.storeId == id)
          Positioned(
            right: 5,
            bottom: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Text(
                "current_selection".translate(context),
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }

  Widget infoStore(StoreResponse store) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          store.storeName.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
            "${store.address1} - ${store.address2} - ${store.address3} - ${store.address4}"),
        const SizedBox(height: 5),
        Row(
          children: [
            const Icon(Icons.phone, color: AppColors.statusBarColor),
            const SizedBox(width: 5),
            Text(store.hotlineNumber.toString()),
          ],
        ),
        const SizedBox(height: 5),
        isOpenStore(store),
      ],
    );
  }

  Widget isOpenStore(StoreResponse store) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(52, 175, 84, 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            store.checkOpen()
                ? "open".translate(context)
                : "close".translate(context),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text("${store.openingHour} - ${store.closingHour}"),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
