import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
          label: AppLocalizations.of(context).home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(FontAwesomeIcons.cartShopping),
          label: AppLocalizations.of(context).order,
        ),
        BottomNavigationBarItem(
          icon: const Icon(FontAwesomeIcons.clockRotateLeft),
          label: AppLocalizations.of(context).activity,
        ),
        BottomNavigationBarItem(
          icon: const Icon(FontAwesomeIcons.store),
          label: AppLocalizations.of(context).store,
        ),
        BottomNavigationBarItem(
          icon: const Icon(FontAwesomeIcons.bars),
          label: AppLocalizations.of(context).other,
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
