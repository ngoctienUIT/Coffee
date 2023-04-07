import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:coffee_admin/src/domain/entities/user/user_response.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constants/constants.dart';

class ItemAccount extends StatelessWidget {
  const ItemAccount({Key? key, required this.user}) : super(key: key);

  final UserResponse user;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
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
                  : Image.network(user.imageUrl!, height: 100),
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
