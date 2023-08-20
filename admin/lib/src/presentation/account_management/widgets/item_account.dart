import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constants/constants.dart';
import '../../../data/remote/response/user/user_response.dart';
import '../../order/widgets/item_loading.dart';

class ItemAccount extends StatelessWidget {
  const ItemAccount({Key? key, required this.user}) : super(key: key);

  final UserResponse user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        // margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            ClipOval(
              child: user.imageUrl == null
                  ? Image.asset(AppImages.imgNonAvatar, height: 100)
                  : CachedNetworkImage(
                      height: 80,
                      width: 80,
                      imageUrl: user.imageUrl!,
                      placeholder: (context, url) => itemLoading(100, 100, 0),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.displayName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text("Email: ${user.email}"),
                  const SizedBox(height: 10),
                  Text(
                      "${"phone_number".translate(context)}: ${user.phoneNumber}"),
                  const SizedBox(height: 10),
                  Text(user.userRole)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
