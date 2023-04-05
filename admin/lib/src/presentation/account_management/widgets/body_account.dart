import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:coffee_admin/src/domain/entities/user/user_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constants/constants.dart';
import '../bloc/account_bloc.dart';
import '../bloc/account_event.dart';
import '../bloc/account_state.dart';

class BodyAccount extends StatelessWidget {
  const BodyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        if (state is InitState ||
            state is AccountLoading ||
            state is RefreshLoading) {
          return _buildLoading();
        }
        if (state is AccountError || state is RefreshError) {
          return Center(
            child: Text(state is AccountError
                ? state.message!
                : (state as RefreshError).message!),
          );
        }
        if (state is AccountLoaded || state is RefreshLoaded) {
          List<UserResponse> listAccount = state is AccountLoaded
              ? state.listAccount
              : (state as RefreshLoaded).listAccount;
          int indexState = state is AccountLoaded
              ? state.index
              : (state as RefreshLoaded).index;
          return RefreshIndicator(
            onRefresh: () async {
              context.read<AccountBloc>().add(RefreshData(indexState));
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: listAccount.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: itemAccount(context, listAccount[index]),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget itemAccount(BuildContext context, UserResponse user) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
          // margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              ClipOval(
                child: user.imageUrl == null
                    ? Image.asset(AppImages.imgNonAvatar, height: 100)
                    : Image.network(user.imageUrl!, height: 100),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.displayName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text("Email: ${user.email}"),
                    const SizedBox(height: 10),
                    Text(
                        "${"phone_number".translate(context)}: ${user.phoneNumber}"),
                    const SizedBox(height: 10),
                    Text(user.userRole)
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
