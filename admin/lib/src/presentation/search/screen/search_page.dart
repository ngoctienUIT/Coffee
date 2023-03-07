import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../login/widgets/custom_text_input.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchFoodController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
        elevation: 0,
        title: SizedBox(
          height: 40,
          child: customTextInput(
            controller: searchFoodController,
            hint: "Tìm kiếm tên món ăn",
            radius: 90,
            contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            textInputAction: TextInputAction.search,
            textStyle: const TextStyle(fontSize: 13),
            backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
            suffixIcon: const Icon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.grey,
            ),
          ),
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
        children: const [],
      ),
    );
  }
}
