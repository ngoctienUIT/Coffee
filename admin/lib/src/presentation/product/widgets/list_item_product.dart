import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../domain/repositories/product/product_response.dart';
import '../../view_product/screen/view_product_page.dart';

class ListItemProduct extends StatelessWidget {
  const ListItemProduct({Key? key, required this.listProduct})
      : super(key: key);

  final List<ProductResponse> listProduct;

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
                screen: ViewProductPage(index: index),
                begin: const Offset(0, 1),
              ));
            },
            child: Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                extentRatio: 0.2,
                children: [
                  SlidableAction(
                    onPressed: (context) {},
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Row(
          children: [
            listProduct[index].image == null
                ? Image.asset(
                    AppImages.imgLogo,
                    height: 100,
                    width: 100,
                  )
                : Image.network(
                    listProduct[index].image!,
                    height: 100,
                    width: 100,
                  ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listProduct[index].name,
                    style: const TextStyle(fontSize: 16),
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
              width: 70,
              child: Text(
                listProduct[index].price.toString() +
                    listProduct[index].currency,
                style: const TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
