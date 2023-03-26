import 'package:coffee/src/core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../widgets/body_other.dart';
import '../widgets/header_other.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.statusBarColor,
      body: SafeArea(
        child: Column(
          children: const [
            HeaderOtherPage(),
            Expanded(child: BodyOtherPage()),
          ],
        ),
      ),
    );
  }
}
