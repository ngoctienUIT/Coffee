import 'package:flutter/material.dart';

import '../widgets/body_other.dart';
import '../widgets/header_other.dart';

class OtherPage extends StatefulWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  State<OtherPage> createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
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
