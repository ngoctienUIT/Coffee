import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Container(
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
    );
  }
}
