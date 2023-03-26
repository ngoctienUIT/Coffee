import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../login/widgets/custom_text_input.dart';
import '../../search/screen/search_page.dart';

class HeaderProductPage extends StatelessWidget {
  const HeaderProductPage({Key? key, required this.tabController})
      : super(key: key);
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            height: 40,
            child: CustomTextInput(
              hint: "search_name_dish".translate(context),
              radius: 90,
              contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              textStyle: const TextStyle(fontSize: 13),
              backgroundColor: AppColors.bgColor,
              onPress: () {
                Navigator.of(context).push(createRoute(
                  screen: const SearchPage(),
                  begin: const Offset(1, 0),
                ));
              },
              suffixIcon: const Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 115,
          child: TabBar(
            controller: tabController,
            physics: const BouncingScrollPhysics(),
            isScrollable: true,
            labelColor: Colors.black87,
            // labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelColor: const Color.fromRGBO(45, 216, 198, 1),
            // unselectedLabelStyle: const TextStyle(fontSize: 16),
            indicatorColor: Colors.green,
            tabs: List.generate(listItemProduct.length, (index) {
              return SizedBox(
                width: MediaQuery.of(context).size.width / 3.7,
                child: Column(
                  children: [
                    Image.asset(
                      listItemProduct[index]["image"]!,
                      height: 70,
                    ),
                    Text(
                      listItemProduct[index]["name"]!.toUpperCase(),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
