import 'package:flutter/material.dart';

import '../widgets/body_other.dart';
import '../widgets/header_other.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(177, 40, 48, 1),
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
