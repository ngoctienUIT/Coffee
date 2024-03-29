import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/utils/constants/constants.dart';
import '../../signup/widgets/custom_text_input.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';

class AppBarSearch extends StatelessWidget implements PreferredSizeWidget {
  const AppBarSearch({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.bgColor,
      elevation: 0,
      title: SizedBox(
        height: 40,
        child: CustomTextInput(
          controller: controller,
          hint: AppLocalizations.of(context)!.searchNameDish,
          radius: 90,
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          textInputAction: TextInputAction.search,
          textStyle: const TextStyle(fontSize: 13),
          backgroundColor: AppColors.bgColor,
          suffixIcon: const Icon(
            FontAwesomeIcons.magnifyingGlass,
            color: Colors.grey,
          ),
          onChanged: (value) {
            context.read<SearchBloc>().add(SearchProduct(query: value));
          },
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
