import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee/injection.dart';
import 'package:coffee/src/core/services/bloc/service_state.dart';
import 'package:coffee/src/core/utils/constants/app_images.dart';
import 'package:coffee/src/data/models/user.dart';
import 'package:coffee/src/presentation/coupon/widgets/app_bar_general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/function/route_function.dart';
import '../../../core/services/bloc/service_bloc.dart';
import '../../profile/screen/profile_page.dart';
import '../../search/screen/search_page.dart';
import '../../store/widgets/item_loading.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.elevation,
    required this.isPick,
    required this.title,
  }) : super(key: key);

  final double? elevation;
  final bool isPick;
  final String title;

  @override
  Widget build(BuildContext context) {
    return isPick
        ? AppBarGeneral(elevation: 0, title: title)
        : BlocBuilder<ServiceBloc, ServiceState>(
            buildWhen: (previous, current) =>
                current is ChangeUserInfoState || current is InitServiceState,
            builder: (context, state) {
              final user = getIt<User>();
              return AppBar(
                backgroundColor: Colors.white,
                elevation: elevation,
                leading: InkWell(
                  onTap: () {
                    Navigator.of(context).push(createRoute(
                      screen: ProfilePage(user: user),
                      begin: const Offset(1, 0),
                    ));
                  },
                  borderRadius: BorderRadius.circular(90),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ClipOval(
                      child: user.imageUrl == null
                          ? Image.asset(AppImages.imgNonAvatar, height: 80)
                          : CachedNetworkImage(
                              height: 50,
                              width: 50,
                              imageUrl: user.imageUrl ?? "",
                              placeholder: (context, url) =>
                                  itemLoading(80, 80, 90),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                    ),
                  ),
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
            },
          );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
