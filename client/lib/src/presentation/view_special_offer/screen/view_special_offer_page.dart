import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../domain/repositories/coupon/coupon_response.dart';
import '../../store/widgets/item_loading.dart';

class ViewSpecialOfferPage extends StatelessWidget {
  const ViewSpecialOfferPage({Key? key, required this.coupon})
      : super(key: key);

  final CouponResponse coupon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  imageUrl: coupon.imageUrl ?? "",
                  fit: BoxFit.fitWidth,
                  placeholder: (context, url) =>
                      itemLoading(150, MediaQuery.of(context).size.width, 0),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(90),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      coupon.couponName,
                      maxLines: 2,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text("Mô tả"),
                    const SizedBox(height: 10),
                    Text(
                      coupon.content,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    const Text("Thời gian"),
                    const SizedBox(height: 10),
                    Text(
                      coupon.dueDate,
                      maxLines: 2,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
