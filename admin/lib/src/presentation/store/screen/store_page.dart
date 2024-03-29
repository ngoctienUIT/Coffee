import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_admin/injection.dart';
import 'package:coffee_admin/src/core/function/loading_animation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:coffee_admin/src/data/local/entity/store_entity.dart';
import 'package:coffee_admin/src/presentation/add_store/screen/add_store_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../core/widgets/custom_alert_dialog.dart';
import '../../../data/models/user.dart';
import '../../order/widgets/item_loading.dart';
import '../../signup/widgets/custom_text_input.dart';
import '../bloc/store_bloc.dart';
import '../bloc/store_event.dart';
import '../bloc/store_state.dart';
import '../widgets/bottom_sheet.dart';

class StorePage extends StatelessWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StoreBloc>(
      create: (_) => getIt<StoreBloc>()..add(FetchData()),
      child: const StoreView(),
    );
  }
}

class StoreView extends StatefulWidget {
  const StoreView({Key? key}) : super(key: key);

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  TextEditingController searchStoreController = TextEditingController();

  @override
  void dispose() {
    searchStoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = getIt<User>();
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: appBar(),
      body: SafeArea(child: bodyStore()),
      floatingActionButton: user.userRole == "ADMIN"
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(createRoute(
                  screen: AddStorePage(
                    onChange: () => context
                        .read<StoreBloc>()
                        .add(UpdateData(searchStoreController.text)),
                  ),
                  begin: const Offset(0, 1),
                ));
              },
              backgroundColor: AppColors.statusBarColor,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  AppBar appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () => Navigator.pop(context),
      ),
      title: SizedBox(
        height: 40,
        child: CustomTextInput(
          onChanged: (value) {
            context.read<StoreBloc>().add(SearchStore(storeName: value));
          },
          controller: searchStoreController,
          hint: AppLocalizations.of(context)!.addressSearch,
          radius: 90,
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          textInputAction: TextInputAction.search,
          textStyle: const TextStyle(fontSize: 13),
          suffixIcon: const Icon(
            FontAwesomeIcons.magnifyingGlass,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget bodyStore() {
    User user = getIt<User>();
    List<StoreEntity> listStore = [];
    return BlocConsumer<StoreBloc, StoreState>(
      listener: (context, state) {
        if (state is StoreError) {
          customToast(context, state.message.toString());
        }
        if (state is StoreLoading && !state.check) {
          loadingAnimation(context);
        }
        if (state is DeleteSuccess) {
          Navigator.pop(context);
          customToast(
              context, AppLocalizations.of(context)!.deleteSuccessfully);
        }
      },
      buildWhen: (previous, current) =>
          !(current is StoreLoading && !current.check),
      builder: (context, state) {
        print(state);
        if (state is StoreLoaded || state is DeleteSuccess) {
          if (state is StoreLoaded) {
            listStore = [];
            listStore.addAll(state.listStore);
          }
          if (state is DeleteSuccess) {
            listStore.removeWhere((element) => element.storeId == state.id);
          }
          return RefreshIndicator(
            onRefresh: () async {
              context
                  .read<StoreBloc>()
                  .add(SearchStore(storeName: searchStoreController.text));
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: listStore.length,
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 60),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => showStoreBottomSheet(
                    context,
                    listStore[index],
                    () {
                      context.read<StoreBloc>().add(
                          SearchStore(storeName: searchStoreController.text));
                    },
                  ),
                  child: user.userRole != "ADMIN"
                      ? itemStore(listStore[index])
                      : Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            extentRatio: 0.2,
                            children: [
                              SlidableAction(
                                onPressed: (_) {
                                  _showAlertDialog(context, () {
                                    context.read<StoreBloc>().add(
                                        DeleteEvent(listStore[index].storeId));
                                  });
                                },
                                backgroundColor: AppColors.statusBarColor,
                                foregroundColor:
                                    const Color.fromRGBO(231, 231, 231, 1),
                                icon: FontAwesomeIcons.trash,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ],
                          ),
                          child: itemStore(listStore[index]),
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

  Widget itemStore(StoreEntity store) {
    return Card(
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
    );
  }

  Widget infoStore(StoreEntity store) {
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

  Widget isOpenStore(StoreEntity store) {
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
                ? AppLocalizations.of(context)!.open
                : AppLocalizations.of(context)!.close,
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

  Future _showAlertDialog(BuildContext context, VoidCallback onOK) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return customAlertDialog(
          context: context,
          title: AppLocalizations.of(context)!.deleteStore,
          content:
              AppLocalizations.of(context)!.areYouSureYouWantToDeleteThisStore,
          onOK: onOK,
        );
      },
    );
  }
}
