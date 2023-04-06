import 'package:coffee_admin/src/core/utils/extensions/int_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constants/constants.dart';
import '../../../domain/repositories/topping/topping_response.dart';
import '../../forgot_password/widgets/app_bar_general.dart';
import '../bloc/topping_bloc.dart';
import '../bloc/topping_event.dart';
import '../bloc/topping_state.dart';

class ToppingPage extends StatelessWidget {
  const ToppingPage({Key? key, this.onPick}) : super(key: key);

  final Function(ToppingResponse topping)? onPick;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: const AppBarGeneral(title: "Toppings", elevation: 0),
      body: BlocProvider(
        create: (context) => ToppingBloc()..add(FetchData()),
        child: ToppingView(onPick: onPick),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.of(context).push(createRoute(
          //   screen: const AddProductPage(),
          //   begin: const Offset(0, 1),
          // ));
        },
        backgroundColor: AppColors.statusBarColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ToppingView extends StatelessWidget {
  const ToppingView({Key? key, this.onPick}) : super(key: key);

  final Function(ToppingResponse catalogue)? onPick;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToppingBloc, ToppingState>(
      builder: (context, state) {
        if (state is InitState || state is ToppingLoading) {
          return _buildLoading();
        }
        if (state is ToppingError) {
          return Center(child: Text(state.message!));
        }
        if (state is ToppingLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<ToppingBloc>().add(FetchData());
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.all(10),
              itemCount: state.listTopping.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: InkWell(
                    onTap: onPick != null
                        ? () {
                            onPick!(state.listTopping[index]);
                            Navigator.pop(context);
                          }
                        : null,
                    child: itemTopping(state.listTopping[index]),
                  ),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget itemTopping(ToppingResponse topping) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          children: [
            topping.imageUrl.isEmpty
                ? Image.asset(
                    AppImages.imgLogo,
                    height: 80,
                    width: 80,
                  )
                : Image.network(
                    topping.imageUrl,
                    height: 80,
                    width: 80,
                  ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topping.toppingName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.statusBarColor,
                  ),
                ),
                Text(
                  topping.description,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.statusBarColor,
                  ),
                ),
                Text(
                  topping.pricePerService.toCurrency(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.statusBarColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
