import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../signup/widgets/custom_text_input.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchFoodController = TextEditingController();
  bool check = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
        elevation: 0,
        title: SizedBox(
          height: 40,
          child: CustomTextInput(
            controller: searchFoodController,
            hint: "search_name_dish".translate(context),
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
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                const Spacer(),
                InkWell(
                  onTap: () => setState(() => check = true),
                  child: Icon(
                    Icons.menu,
                    color: check ? Colors.red : Colors.grey,
                    size: 35,
                  ),
                ),
                InkWell(
                  onTap: () => setState(() => check = false),
                  child: Icon(
                    Icons.grid_view_rounded,
                    color: check ? Colors.grey : Colors.red,
                    size: 35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
