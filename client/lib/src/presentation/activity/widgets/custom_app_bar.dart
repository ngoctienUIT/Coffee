import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../controls/function/route_function.dart';
import '../../profile/screen/profile_page.dart';
import '../../search/screen/search_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key, this.elevation}) : super(key: key);

  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: elevation,
      leading: InkWell(
        onTap: () {
          Navigator.of(context).push(createRoute(
            screen: const ProfilePage(),
            begin: const Offset(1, 0),
          ));
        },
        borderRadius: BorderRadius.circular(90),
        child: ClipOval(child: Image.asset("assets/coffee_logo.jpg")),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(createRoute(
              screen: const SearchPage(),
              begin: const Offset(1, 0),
            ));
          },
          icon: const Icon(
            FontAwesomeIcons.magnifyingGlass,
            color: Colors.grey,
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
