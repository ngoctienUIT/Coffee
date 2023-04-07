import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/app_colors.dart';
import '../../search_staff/screen/search_staff_page.dart';
import '../../signup/widgets/custom_text_input.dart';
import '../bloc/account_bloc.dart';
import '../bloc/account_event.dart';

class HeaderAccountPage extends StatefulWidget {
  const HeaderAccountPage({Key? key}) : super(key: key);

  @override
  State<HeaderAccountPage> createState() => _HeaderAccountPageState();
}

class _HeaderAccountPageState extends State<HeaderAccountPage>
    with TickerProviderStateMixin {
  late TabController _accountController;

  @override
  void initState() {
    _accountController = TabController(length: 3, vsync: this);
    _accountController.addListener(() {
      context.read<AccountBloc>().add(RefreshData(_accountController.index));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        search(context),
        Container(
          color: Colors.white,
          height: 56,
          width: double.infinity,
          child: Center(
            child: TabBar(
              controller: _accountController,
              isScrollable: true,
              labelColor: Colors.black87,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelColor: const Color.fromRGBO(45, 216, 198, 1),
              unselectedLabelStyle: const TextStyle(fontSize: 16),
              indicatorColor: Colors.green,
              tabs: [
                Tab(text: "all".translate(context)),
                Tab(text: "admin".translate(context)),
                Tab(text: "staff".translate(context)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget search(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        height: 40,
        child: CustomTextInput(
          hint: "Tìm kiếm nhân viên",
          radius: 90,
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          textStyle: const TextStyle(fontSize: 13),
          backgroundColor: AppColors.bgColor,
          onPress: () {
            Navigator.of(context).push(createRoute(
              screen: const SearchStaffPage(),
              begin: const Offset(1, 0),
            ));
          },
          suffixIcon: const Icon(
            FontAwesomeIcons.magnifyingGlass,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
