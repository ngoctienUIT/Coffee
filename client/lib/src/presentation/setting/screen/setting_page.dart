import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/domain/entities/user/user_response.dart';
import 'package:coffee/src/presentation/change_password/screen/change_password_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/function/route_function.dart';
import '../../../domain/api_service.dart';
import '../../coupon/widgets/app_bar_general.dart';
import '../../login/screen/login_page.dart';
import '../../other/widgets/group_item_other.dart';
import '../../other/widgets/item_other.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key, required this.user}) : super(key: key);

  final UserResponse user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGeneral(title: "setting".translate(context), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            groupItemOther("account_settings".translate(context), [
              itemOther(
                "delete_account".translate(context),
                Icons.delete_forever,
                () => _showAlertDialog(context),
              ),
            ]),
            if (user.hashedPassword.isNotEmpty)
              groupItemOther("security".translate(context), [
                itemOther(
                  "change_password".translate(context),
                  Icons.lock,
                  () {
                    Navigator.of(context).push(createRoute(
                      screen: ChangePasswordPage(user: user),
                      begin: const Offset(1, 0),
                    ));
                  },
                ),
              ]),
          ],
        ),
      ),
    );
  }

  Future _showAlertDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('delete_account'.translate(context)),
          content: Text('you_want_delete_your_account'.translate(context)),
          actions: [
            TextButton(
              child: Text('cancel'.translate(context)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('ok'.translate(context)),
              onPressed: () async {
                bool check = await deleteAccount(context);
                if (check && context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    createRoute(
                      screen: const LoginPage(),
                      begin: const Offset(0, 1),
                    ),
                    (route) => false,
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> deleteAccount(BuildContext context) async {
    try {
      ApiService apiService =
          ApiService(Dio(BaseOptions(contentType: "application/json")));
      final prefs = await SharedPreferences.getInstance();
      String id = prefs.getString("userID") ?? "";
      String token = prefs.getString("token") ?? "";
      await apiService.removeUserByID("Bearer $token", id);
      prefs.setBool("isLogin", false);
      return true;
    } on DioError catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      print(error);
      customToast(context, error);
      return false;
    } catch (e) {
      print(e);
      customToast(context, e.toString());
      return false;
    }
  }
}
