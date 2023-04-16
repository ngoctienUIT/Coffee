import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_admin/src/core/utils/extensions/int_extension.dart';
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
      create: (context) => ToppingBloc()..add(FetchData()),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: const AppBarGeneral(title: "Toppings", elevation: 0),
        body: ToppingView(onPick: onPick, listTopping: listTopping),
        floatingActionButton: BlocBuilder<ToppingBloc, ToppingState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(createRoute(
                  screen: AddToppingPage(
                    onChange: () {
                      context.read<ToppingBloc>().add(FetchData());
                    },
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
    return BlocConsumer<ToppingBloc, ToppingState>(
      listener: (context, state) {
        if (state is ToppingError) {
          customToast(context, state.message.toString());
        }
      },
      buildWhen: (previous, current) => current is! PickState,
      builder: (context, state) {
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
            text: "Lưu",
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
        final myContext = context;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: widget.onPick != null
              ? Row(
                  children: [
                    BlocBuilder<ToppingBloc, ToppingState>(
                      buildWhen: (previous, current) => current is PickState,
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
                        onPressed: (context) {
                          Navigator.of(context).push(createRoute(
                            screen: AddToppingPage(
                              topping: listTopping[index],
                              onChange: () {
                                myContext.read<ToppingBloc>().add(FetchData());
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
                        onPressed: (context) {
                          context
                              .read<ToppingBloc>()
                              .add(DeleteEvent(listTopping[index].toppingId!));
                        },
                        backgroundColor: AppColors.statusBarColor,
                        foregroundColor: const Color.fromRGBO(231, 231, 231, 1),
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
}
