import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/presentation/coupon/widgets/app_bar_general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../core/utils/constants/app_colors.dart';

class PolicyPage extends StatefulWidget {
  const PolicyPage({Key? key}) : super(key: key);

  @override
  State<PolicyPage> createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGeneral(title: "policy".translate(context)),
      body: Stack(
        children: [
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.statusBarColor,
                  ),
                )
              : const SizedBox(),
          InAppWebView(
            onLoadStop: (controller, url) {
              setState(() => isLoading = false);
            },
            initialUrlRequest: URLRequest(
                url: Uri.parse(
                    "https://www.highlandscoffee.com.vn/vn/dieu-khoan-va-dieu-kien-ap-dung-cua-ung-dung-highlands-coffee.html")),
          ),
        ],
      ),
    );
  }
}
