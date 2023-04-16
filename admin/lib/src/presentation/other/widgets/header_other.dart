import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/language/bloc/language_cubit.dart';
import '../../../core/utils/constants/constants.dart';
import '../../login/widgets/custom_button.dart';
import '../../order/widgets/item_loading.dart';
import '../../product/widgets/title_bottom_sheet.dart';
import '../bloc/other_bloc.dart';
import '../bloc/other_state.dart';
import 'language_widget.dart';

class HeaderOtherPage extends StatefulWidget {
  const HeaderOtherPage({Key? key}) : super(key: key);

  @override
  State<HeaderOtherPage> createState() => _HeaderOtherPageState();
}

class _HeaderOtherPageState extends State<HeaderOtherPage> {
  int language = 0;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        language = value.getInt('language') ??
            (Platform.localeName.split('_')[0] == "vi" ? 0 : 1);
      });
    });
    super.initState();
  }

  Future changeLanguage(int lang) async {
    if (lang != language) {
      if (lang == 0) {
        BlocProvider.of<LanguageCubit>(context).toVietnamese();
      } else {
        BlocProvider.of<LanguageCubit>(context).toEnglish();
      }
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('language', lang);
      if (!mounted) return;
      setState(() => language = lang);
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtherBloc, OtherState>(
      listener: (context, state) {
        if (state is OtherError) {
          customToast(context, state.message.toString());
        }
      },
      child: Container(
        color: AppColors.statusBarColor,
        child: Column(
          children: [
            const SizedBox(height: 10),
            header(),
            const SizedBox(height: 10),
            body(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return BlocBuilder<OtherBloc, OtherState>(
      buildWhen: (previous, current) => current is ChangeLanguageState,
      builder: (context, state) {
        return Row(
          children: [
            const Spacer(),
            InkWell(
              onTap: () => showMyBottomSheet(context),
              child: Container(
                alignment: Alignment.centerRight,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  border: Border.all(color: Colors.white),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      language == 0 ? "Tiếng Việt" : "English",
                      style: const TextStyle(color: Colors.white),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        );
      },
    );
  }

  Widget body() {
    return BlocBuilder<OtherBloc, OtherState>(
      buildWhen: (previous, current) => current is! ChangeLanguageState,
      builder: (context, state) {
        if (state is OtherLoaded) {
          return Column(
            children: [
              ClipOval(
                child: (state.user.imageUrl == null
                    ? Image.asset(AppImages.imgNonAvatar, height: 100)
                    : CachedNetworkImage(
                        height: 80,
                        width: 80,
                        imageUrl: state.user.imageUrl!,
                        placeholder: (context, url) => itemLoading(80, 80, 90),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )),
              ),
              const SizedBox(height: 10),
              Text(
                state.user.displayName,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                state.user.userRole,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        }
        return _buildLoading();
      },
    );
  }

  void showMyBottomSheet(BuildContext context) {
    bool isVN = language == 0;

    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (context) {
        return Container(
          height: 350,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                children: [
                  const SizedBox(height: 10),
                  titleBottomSheet(
                    "language_selection".translate(context),
                    () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Expanded(
                        child: languageWidget(
                          image: AppImages.imgVietNam,
                          text: "Tiếng Việt",
                          onPress: () => setState(() => isVN = true),
                          isPick: isVN,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: languageWidget(
                          image: AppImages.imgEnglish,
                          text: "English",
                          onPress: () => setState(() => isVN = false),
                          isPick: !isVN,
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: customButton(
                      text: 'ok'.translate(context),
                      isOnPress: true,
                      onPress: () => changeLanguage(isVN ? 0 : 1),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildLoading() {
    var rng = Random();
    return Column(
      children: [
        itemLoading(100, 100, 90),
        const SizedBox(height: 10),
        itemLoading(20, rng.nextDouble() * 50 + 100, 10),
        const SizedBox(height: 10),
        itemLoading(25, 100, 15),
      ],
    );
  }
}
