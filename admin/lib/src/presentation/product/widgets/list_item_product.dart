import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_admin/src/core/utils/extensions/int_extension.dart';
import 'package:coffee_admin/src/presentation/product/widgets/list_product_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../domain/repositories/product/product_response.dart';
import '../../../domain/repositories/product_catalogues/product_catalogues_response.dart';
import '../../view_product/screen/view_product_page.dart';

class ListItemProduct extends StatelessWidget {
  const ListItemProduct({
    Key? key,
    this.productCatalogues,
    required this.listProduct,
    required this.onDelete,
    this.onChange,
  }) : super(key: key);

  final ProductCataloguesResponse? productCatalogues;
  final List<ProductResponse> listProduct;
  final Function(String id) onDelete;
  final VoidCallback? onChange;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView.builder(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: const EdgeInsets.only(bottom: 60),
        itemCount: listProduct.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(createRoute(
                screen: ViewProductPage(
                  productCatalogues: productCatalogues,
                  product: listProduct[index],
                  onChange: onChange == null ? () {} : onChange!,
                ),
                begin: const Offset(0, 1),
              ));
            },
            child: Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                extentRatio: 0.2,
                children: [
                  SlidableAction(
                    onPressed: (context) => onDelete(listProduct[index].id),
                    backgroundColor: AppColors.statusBarColor,
                    foregroundColor: const Color.fromRGBO(231, 231, 231, 1),
                    icon: FontAwesomeIcons.trash,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ],
              ),
              child: itemOrder(index),
            ),
          );
        },
      ),
    );
  }

  Widget itemOrder(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Row(
          children: [
            listProduct[index].image == null
                ? Image.asset(AppImages.imgLogo, height: 100, width: 100)
                : CachedNetworkImage(
                    height: 100,
                    width: 100,
                    imageUrl: listProduct[index].image!,
                    placeholder: (context, url) => productItemLoading(100),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listProduct[index].name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    listProduct[index].description.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 80,
              child: Text(
                listProduct[index].price.toCurrency(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.statusBarColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
