import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_admin/injection.dart';
import 'package:coffee_admin/src/core/function/loading_animation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:coffee_admin/src/data/models/product_catalogues.dart';
import 'package:coffee_admin/src/data/models/user.dart';
import 'package:coffee_admin/src/data/remote/response/product_catalogues/product_catalogues_response.dart';
import 'package:coffee_admin/src/presentation/add_product_catalogues/screen/add_product_catalogues_page.dart';
import 'package:coffee_admin/src/presentation/product/widgets/list_product_loading.dart';
import 'package:coffee_admin/src/presentation/product_catalogues/bloc/product_catalogues_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../core/widgets/custom_alert_dialog.dart';
import '../../forgot_password/widgets/app_bar_general.dart';
import '../../order/widgets/item_loading.dart';
import '../bloc/product_catalogues_event.dart';
import '../bloc/product_catalogues_state.dart';

class ProductCataloguesPage extends StatelessWidget {
  const ProductCataloguesPage({Key? key, this.onPick, this.id})
      : super(key: key);

  final Function(ProductCataloguesResponse catalogue)? onPick;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductCataloguesBloc>()..add(FetchData()),
      child: ProductCataloguesView(id: id, onPick: onPick),
    );
  }
}

class ProductCataloguesView extends StatelessWidget {
  const ProductCataloguesView({Key? key, this.onPick, this.id})
      : super(key: key);

  final Function(ProductCataloguesResponse catalogue)? onPick;
  final String? id;

  @override
  Widget build(BuildContext context) {
    User user = getIt<User>();
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBarGeneral(
          title: AppLocalizations.of(context)!.productCatalogues, elevation: 0),
      body: buildBody(context),
      floatingActionButton: user.userRole == "ADMIN" && onPick == null
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(createRoute(
                  screen: AddProductCataloguesPage(
                    onChange: () =>
                        context.read<ProductCataloguesBloc>().add(UpdateData()),
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

  Widget buildBody(BuildContext context) {
    User user = getIt<User>();
    List<ProductCataloguesResponse> listProductCatalogues = [];
    return BlocConsumer<ProductCataloguesBloc, ProductCataloguesState>(
      listener: (context, state) {
        if (state is ProductCataloguesError) {
          customToast(context, state.message.toString());
        }
        if (state is ProductCataloguesLoading && !state.check) {
          loadingAnimation(context);
        }
        if (state is DeleteSuccess) {
          Navigator.pop(context);
          customToast(
              context, AppLocalizations.of(context)!.deleteSuccessfully);
        }
      },
      buildWhen: (previous, current) =>
          !(current is ProductCataloguesLoading && !current.check),
      builder: (context, state) {
        if (state is ProductCataloguesLoaded || state is DeleteSuccess) {
          if (state is ProductCataloguesLoaded) {
            listProductCatalogues = [];
            listProductCatalogues.addAll(state.listProductCatalogues);
          }
          if (state is DeleteSuccess) {
            listProductCatalogues
                .removeWhere((element) => element.id == state.id);
          }
          return RefreshIndicator(
            onRefresh: () async {
              context.read<ProductCataloguesBloc>().add(FetchData());
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 60),
              itemCount: listProductCatalogues.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: InkWell(
                    onTap: onPick != null
                        ? () {
                            onPick!(listProductCatalogues[index]);
                            Navigator.pop(context);
                          }
                        : null,
                    child: Stack(
                      children: [
                        user.userRole == "ADMIN" && onPick == null
                            ? Slidable(
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  extentRatio: 0.32,
                                  children: [
                                    SlidableAction(
                                      onPressed: (_) {
                                        Navigator.of(context).push(createRoute(
                                          screen: AddProductCataloguesPage(
                                            productCatalogues:
                                                ProductCatalogues.fromResponse(
                                                    listProductCatalogues[
                                                        index]),
                                            onChange: () {
                                              context
                                                  .read<ProductCataloguesBloc>()
                                                  .add(UpdateData());
                                            },
                                          ),
                                          begin: const Offset(0, 1),
                                        ));
                                      },
                                      backgroundColor: AppColors.statusBarColor,
                                      foregroundColor: const Color.fromRGBO(
                                          231, 231, 231, 1),
                                      icon: FontAwesomeIcons.penToSquare,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    SlidableAction(
                                      onPressed: (_) {
                                        _showAlertDialog(context, () {
                                          context
                                              .read<ProductCataloguesBloc>()
                                              .add(DeleteEvent(
                                                  listProductCatalogues[index]
                                                      .id));
                                        });
                                      },
                                      backgroundColor: AppColors.statusBarColor,
                                      foregroundColor: const Color.fromRGBO(
                                          231, 231, 231, 1),
                                      icon: FontAwesomeIcons.trash,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ],
                                ),
                                child: productCataloguesItem(
                                    listProductCatalogues[index]),
                              )
                            : productCataloguesItem(
                                listProductCatalogues[index]),
                        if (id == listProductCatalogues[index].id)
                          Positioned(
                            right: 5,
                            top: 5,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.currentSelection,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                      ],
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

  Widget productCataloguesItem(ProductCataloguesResponse productCatalogues) {
    return Card(
      child: Row(
        children: [
          CachedNetworkImage(
            height: 80,
            width: 80,
            imageUrl: productCatalogues.image,
            placeholder: (context, url) => itemLoading(80, 80, 0),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productCatalogues.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.statusBarColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  productCatalogues.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    var rng = Random();
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 60),
      physics: const BouncingScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          child: Row(
            children: [
              productItemLoading(80),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    itemLoading(20, rng.nextDouble() * 100 + 100, 10),
                    const SizedBox(height: 10),
                    itemLoading(15, double.infinity, 10),
                    const SizedBox(height: 5),
                    itemLoading(15, double.infinity, 10),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future _showAlertDialog(BuildContext context, VoidCallback onOK) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return customAlertDialog(
          context: context,
          title: AppLocalizations.of(context)!.deleteProductCatalogues,
          content: AppLocalizations.of(context)!
              .areYouSureYouWantToDeleteThisProductCategory,
          onOK: onOK,
        );
      },
    );
  }
}
