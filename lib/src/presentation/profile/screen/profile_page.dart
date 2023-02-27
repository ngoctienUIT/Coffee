import 'package:coffee/src/presentation/profile/widgets/header_profile.dart';
import 'package:flutter/material.dart';

import '../widgets/body_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(177, 40, 48, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Hồ Sơ",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: const [
          HeaderProfilePage(),
          Expanded(child: BodyProfilePage()),
        ],
      ),
    );
  }
}
