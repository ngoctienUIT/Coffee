import 'package:coffee/src/core/utils/extensions/int_extension.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api_service.dart';
import '../../login/widgets/custom_button.dart';

class BottomCartPage extends StatelessWidget {
  const BottomCartPage(
      {Key? key, required this.total, required this.id, required this.onPress})
      : super(key: key);

  final int total;
  final String id;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Text(
                "total".translate(context),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              Text(
                total.toCurrency(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            ],
          ),
          customButton(
            text: "cancel_order".translate(context),
            onPress: () => cancelOrder().then((value) {
              onPress();
              Navigator.pop(context);
            }),
            isOnPress: true,
          ),
        ],
      ),
    );
  }

  Future cancelOrder() async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      await apiService.cancelOrder("Bearer $token", id);
    } catch (e) {
      print(e);
    }
  }
}
