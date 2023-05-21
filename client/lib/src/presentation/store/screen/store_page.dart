import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee/src/core/services/bloc/service_event.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/signup/widgets/custom_text_input.dart';
import 'package:coffee/src/presentation/store/bloc/store_bloc.dart';
import 'package:coffee/src/presentation/store/bloc/store_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/services/bloc/service_bloc.dart';
import '../../../core/services/bloc/service_state.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../data/models/preferences_model.dart';
import '../../../data/models/store.dart';
import '../../activity/widgets/custom_app_bar.dart';
import '../bloc/store_event.dart';
import '../widgets/bottom_sheet.dart';
import '../widgets/item_loading.dart';

class StorePage extends StatelessWidget {
  const StorePage({
    Key? key,
    this.onPress,
    required this.isPick,
    this.onChange,
  }) : super(key: key);

  final Function(Store store)? onPress;
  final VoidCallback? onChange;
  final bool isPick;

  @override
  Widget build(BuildContext context) {
    PreferencesModel preferencesModel =
        context.read<ServiceBloc>().preferencesModel;
    return BlocProvider<StoreBloc>(
      create: (_) => StoreBloc(preferencesModel)..add(FetchData()),
      child: StoreView(
        onPress: onPress,
        isPick: isPick,
        onChange: onChange,
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
  }) : super(key: key);

  final Function(Store store)? onPress;
  final VoidCallback? onChange;
  final bool isPick;

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
    return BlocListener<StoreBloc, StoreState>(
      listener: (context, state) {
        if (state is StoreError) {
          customToast(context, state.message.toString());
        }
      },
      child: buildBody(),
    );
  }

  Widget buildBody() {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        elevation: 0,
        isPick: widget.isPick,
        title: "store".translate(context),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            headerStore(),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<ServiceBloc, ServiceState>(
                buildWhen: (previous, current) => current is ChangeStoreState,
                builder: (context, state) {
                  return bodyStore();
                },
              ),
            ),
          ],
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
    print("rebuild list store");
    return BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        print(state);
        PreferencesModel preferencesModel =
            context.read<ServiceBloc>().preferencesModel;
        String storeID = preferencesModel.storeID ?? "";
        if (state is StoreLoaded) {
          List<Store> listStore = state.listStore;
          if (preferencesModel.listStore.length != listStore.length) {
            context.read<ServiceBloc>().add(
                SetDataEvent(preferencesModel.copyWith(listStore: listStore)));
          }
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: listStore.length,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => showStoreBottomSheet(
                  context,
                  listStore[index],
                  () {
                    if (widget.onPress != null) {
                      widget.onPress!(listStore[index]);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      SharedPreferences.getInstance().then((value) {
                        value.setString(
                            "storeID", listStore[index].storeId ?? "");
                        value.setBool("isBringBack", false);
                        context.read<ServiceBloc>().add(ChangeStoreEvent());
                        Navigator.pop(context);
                        if (widget.onChange != null) widget.onChange!();
                      });
                    }
                  },
                ),
                child: itemStore(listStore[index], storeID),
              );
            },
          );
        }

        return _buildLoading();
      },
    );
  }

  Widget itemStore(Store store, String id) {
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

  Widget infoStore(Store store) {
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

  Widget isOpenStore(Store store) {
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

  @override
  bool get wantKeepAlive => true;
}
