import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/constants/constants.dart';

Widget toast(String text) {
  return Card(
    elevation: 5,
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Image.asset(AppImages.imgLogo, height: 40),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
        ],
      ),
    ),
  );
}

void customToast(BuildContext context, String text) {
  FToast fToast = FToast();
  fToast.init(context);
  fToast.showToast(
    child: toast(text),
    toastDuration: const Duration(seconds: 3),
    gravity: ToastGravity.BOTTOM,
    fadeDuration: const Duration(seconds: 1),
  );
}
