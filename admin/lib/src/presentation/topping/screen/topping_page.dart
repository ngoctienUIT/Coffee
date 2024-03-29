import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_admin/injection.dart';
import 'package:coffee_admin/src/core/function/loading_animation.dart';
import 'package:coffee_admin/src/core/utils/extensions/int_extension.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:coffee_admin/src/data/models/topping.dart';
import 'package:coffee_admin/src/presentation/add_topping/screen/add_topping_page.dart';
import 'package:coffee_admin/src/presentation/login/widgets/custom_button.dart';
import 'package:coffee_admin/src/presentation/order/widgets/item_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../core/widgets/custom_alert_dialog.dart';
import '../../../data/models/user.dart';
import '../../forgot_password/widgets/app_bar_general.dart';
import '../bloc/topping_bloc.dart';
import '../bloc/topping_event.dart';
import '../bloc/topping_state.dart';

class ToppingPage extends StatelessWidget {
  const ToppingPage({Key? key, this.onPick, this.listTopping})
      : super(key: key);

  final Function(List<Topping> list)? onPick;
  final List<String>? listTopping;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ToppingBloc>()..add(FetchData()),
      child: ToppingView(onPick: onPick, listTopping: listTopping),
    );
  }
}

class ToppingView extends StatefulWidget {
  const ToppingView({Key? key, this.onPick, this.listTopping})
      : super(key: key);

  final Function(List<Topping> list)? onPick;
  final List<String>? listTopping;

  @override
  State<ToppingView> createState() => _ToppingViewState();
}

class _ToppingViewState extends State<ToppingView> {
  List<Topping> listTopping = [];

  @override
  Widget build(BuildContext context) {
    User user = getIt<User>();
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: const AppBarGeneral(title: "Topping", elevation: 0),
      body: bodyTopping(),
      floatingActionButton: user.userRole == "ADMIN" && widget.onPick == null
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(createRoute(
                  screen: AddToppingPage(
                    onChange: () {
                      context.read<ToppingBloc>().add(UpdateData());
                    },
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

  Widget bodyTopping() {
    return BlocConsumer<ToppingBloc, ToppingState>(
      listener: (context, state) {
        if (state is ToppingError) {
          customToast(context, state.message.toString());
        }
        if (state is ToppingLoading && !state.check) {
          loadingAnimation(context);
        }
        if (state is DeleteSuccess) {
          Navigator.pop(context);
          customToast(
              context, AppLocalizations.of(context)!.deleteSuccessfully);
        }
      },
      buildWhen: (previous, current) =>
          (current is! PickState) &&
          !(current is ToppingLoading && !current.check),
      builder: (context, state) {
        if (state is ToppingLoaded || state is DeleteSuccess) {
          if (state is ToppingLoaded) {
            listTopping = state.listTopping
                .map((e) => Topping.fromToppingResponse(e))
                .toList();
            if (widget.listTopping != null) {
              for (int i = 0; i < listTopping.length; i++) {
                if (widget.listTopping!.contains(listTopping[i].toppingId)) {
                  listTopping[i].isCheck = true;
                }
              }
            }
          }
          if (state is DeleteSuccess) {
            listTopping.removeWhere((element) => element.toppingId == state.id);
          }
          return widget.onPick == null
              ? RefreshIndicator(
                  onRefresh: () async {
                    context.read<ToppingBloc>().add(FetchData());
                  },
                  child: listToppingWidget(listTopping),
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      listToppingWidget(listTopping),
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
    return BlocBuilder<ToppingBloc, ToppingState>(
      buildWhen: (previous, current) => current is PickState,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: customButton(
            text: AppLocalizations.of(context)!.save,
            isOnPress: true,
            onPress: () {
              widget.onPick!(
                  listTopping.where((element) => element.isCheck).toList());
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  Widget listToppingWidget(List<Topping> listTopping) {
    User user = getIt<User>();
    return ListView.builder(
      physics: widget.onPick == null
          ? const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            )
          : const NeverScrollableScrollPhysics(),
      shrinkWrap: widget.onPick == null ? false : true,
      padding: EdgeInsets.fromLTRB(10, 10, 10, widget.onPick == null ? 60 : 10),
      itemCount: listTopping.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: user.userRole != "ADMIN"
              ? itemTopping(listTopping[index])
              : widget.onPick != null
                  ? Row(
                      children: [
                        BlocBuilder<ToppingBloc, ToppingState>(
                          buildWhen: (previous, current) =>
                              current is PickState,
                          builder: (context, state) {
                            return Checkbox(
                              value: listTopping[index].isCheck,
                              onChanged: (value) {
                                listTopping[index].isCheck = value!;
                                context.read<ToppingBloc>().add(PickEvent());
                              },
                            );
                          },
                        ),
                        Expanded(child: itemTopping(listTopping[index])),
                      ],
                    )
                  : Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        extentRatio: 0.35,
                        children: [
                          SlidableAction(
                            onPressed: (_) {
                              Navigator.of(context).push(createRoute(
                                screen: AddToppingPage(
                                  topping: listTopping[index],
                                  onChange: () {
                                    context
                                        .read<ToppingBloc>()
                                        .add(UpdateData());
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
                            onPressed: (_) {
                              _showAlertDialog(context, () {
                                context.read<ToppingBloc>().add(
                                    DeleteEvent(listTopping[index].toppingId!));
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
                      child: itemTopping(listTopping[index]),
                    ),
        );
      },
    );
  }

  Widget itemTopping(Topping topping) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          children: [
            topping.imageUrl!.isEmpty
                ? Image.asset(AppImages.imgLogo, height: 80, width: 80)
                : CachedNetworkImage(
                    height: 80,
                    width: 80,
                    imageUrl: topping.imageUrl!,
                    placeholder: (context, url) => itemLoading(80, 80, 0),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topping.toppingName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.statusBarColor,
                  ),
                ),
                Text(
                  topping.description,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.statusBarColor,
                  ),
                ),
                Text(
                  topping.pricePerService.toCurrency(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.statusBarColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(10, 10, 10, widget.onPick == null ? 60 : 10),
      physics: const BouncingScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return widget.onPick != null
            ? Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                  ),
                  Expanded(child: itemToppingLoading()),
                ],
              )
            : itemToppingLoading();
      },
    );
  }

  Widget itemToppingLoading() {
    var rng = Random();
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            const SizedBox(width: 10),
            itemLoading(80, 80, 0),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  itemLoading(20, rng.nextDouble() * 100 + 100, 10),
                  const SizedBox(height: 10),
                  itemLoading(15, rng.nextDouble() * 150 + 100, 10),
                  const SizedBox(height: 10),
                  itemLoading(15, 100, 10),
                ],
              ),
            )
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
          title: AppLocalizations.of(context)!.removeTopping,
          content: AppLocalizations.of(context)!
              .areYouSureYouWantToRemoveThisTopping,
          onOK: onOK,
        );
      },
    );
  }
}
