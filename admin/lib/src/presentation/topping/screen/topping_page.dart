import 'package:coffee_admin/src/core/utils/extensions/int_extension.dart';
import 'package:coffee_admin/src/data/models/topping.dart';
import 'package:coffee_admin/src/presentation/add_topping/screen/add_topping_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/function/route_function.dart';
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
    return BlocProvider(
      create: (context) => ToppingBloc()..add(FetchData()),
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: const AppBarGeneral(title: "Toppings", elevation: 0),
        body: ToppingView(onPick: onPick),
        floatingActionButton: BlocBuilder<ToppingBloc, ToppingState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(createRoute(
                  screen: AddToppingPage(
                    onChange: () {
                      context.read<ToppingBloc>().add(FetchData());
                    },
                  ),
                  begin: const Offset(0, 1),
                ));
              },
              backgroundColor: AppColors.statusBarColor,
              child: const Icon(Icons.add),
            );
          },
        ),
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
          final listTopping = state.listTopping;

          return RefreshIndicator(
            onRefresh: () async {
              context.read<ToppingBloc>().add(FetchData());
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 60),
              itemCount: listTopping.length,
              itemBuilder: (context, index) {
                final myContext = context;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: InkWell(
                    onTap: onPick != null
                        ? () {
                            onPick!(listTopping[index]);
                            Navigator.pop(context);
                          }
                        : null,
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        extentRatio: 0.35,
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              Navigator.of(context).push(createRoute(
                                screen: AddToppingPage(
                                  topping: Topping.fromToppingResponse(
                                      listTopping[index]),
                                  onChange: () {
                                    myContext
                                        .read<ToppingBloc>()
                                        .add(FetchData());
                                  },
                                ),
                                begin: const Offset(0, 1),
                              ));
                            },
                            backgroundColor: AppColors.statusBarColor,
                            foregroundColor:
                                const Color.fromRGBO(231, 231, 231, 1),
                            icon: FontAwesomeIcons.penToSquare,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              context.read<ToppingBloc>().add(
                                  DeleteEvent(listTopping[index].toppingId));
                            },
                            backgroundColor: AppColors.statusBarColor,
                            foregroundColor:
                                const Color.fromRGBO(231, 231, 231, 1),
                            icon: FontAwesomeIcons.trash,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ],
                      ),
                      child: itemTopping(listTopping[index]),
                    ),
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
