import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../forgot_password/widgets/app_bar_general.dart';

class PolicyPage extends StatelessWidget {
  const PolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarGeneral(title: "Chính sách"),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
            url: Uri.parse(
                "https://www.highlandscoffee.com.vn/vn/dieu-khoan-va-dieu-kien-ap-dung-cua-ung-dung-highlands-coffee.html")),
      ),
    );
  }
}
