import 'package:coffee/src/core/utils/constants/app_images.dart';
import 'package:coffee/src/presentation/coupon/widgets/app_bar_general.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/function/route_function.dart';
import '../../search/screen/search_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.elevation,
    required this.isPick,
    required this.title,
    required this.onChange,
  }) : super(key: key);

  final double? elevation;
  final bool isPick;
  final String title;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return isPick
        ? AppBarGeneral(elevation: 0, title: title)
        : AppBar(
            backgroundColor: Colors.white,
            elevation: elevation,
            leading: InkWell(
              onTap: () {
                // Navigator.of(context).push(createRoute(
                //   screen: ProfilePage(),
                //   begin: const Offset(1, 0),
                // ));
              },
              borderRadius: BorderRadius.circular(90),
              child: ClipOval(child: Image.asset(AppImages.imgNonAvatar)),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(createRoute(
                    screen: SearchPage(onChange: onChange),
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
