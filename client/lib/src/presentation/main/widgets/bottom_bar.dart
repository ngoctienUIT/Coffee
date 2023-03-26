import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key, required this.currentTab, required this.onTab})
      : super(key: key);

  final int currentTab;
  final Function(int value) onTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: const Icon(FontAwesomeIcons.house),
          label: 'home'.translate(context),
        ),
        BottomNavigationBarItem(
          icon: const Icon(FontAwesomeIcons.cartShopping),
          label: 'order'.translate(context),
        ),
        BottomNavigationBarItem(
          icon: const Icon(FontAwesomeIcons.clockRotateLeft),
          label: 'activity'.translate(context),
        ),
        BottomNavigationBarItem(
          icon: const Icon(FontAwesomeIcons.store),
          label: 'store'.translate(context),
        ),
        BottomNavigationBarItem(
          icon: const Icon(FontAwesomeIcons.bars),
          label: 'other'.translate(context),
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: currentTab,
      selectedItemColor: const Color.fromRGBO(173, 149, 121, 1),
      unselectedItemColor: Colors.grey,
      iconSize: 20,
      elevation: 10,
      backgroundColor: Colors.white,
      onTap: (value) => onTab(value),
    );
  }
}
