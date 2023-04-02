import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:coffee_admin/src/presentation/add_store/screen/add_store_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/function/route_function.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../domain/repositories/store/store_response.dart';
import '../../signup/widgets/custom_text_input.dart';
import '../bloc/store_bloc.dart';
import '../bloc/store_event.dart';
import '../bloc/store_state.dart';
import '../widgets/bottom_sheet.dart';

class StorePage extends StatelessWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StoreBloc>(
      create: (_) => StoreBloc()..add(FetchData()),
      child: const StoreView(),
    );
  }
}

class StoreView extends StatefulWidget {
  const StoreView({Key? key}) : super(key: key);

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  TextEditingController searchAddressController = TextEditingController();

  @override
  void dispose() {
    searchAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: appBar(),
      body: SafeArea(child: bodyStore()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(createRoute(
            screen: const AddStorePage(),
            begin: const Offset(0, 1),
          ));
        },
        backgroundColor: AppColors.statusBarColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () => Navigator.pop(context),
      ),
      title: SizedBox(
        height: 40,
        child: CustomTextInput(
          onChanged: (value) {
            context.read<StoreBloc>().add(SearchStore(storeName: value));
          },
          controller: searchAddressController,
          hint: "address_search".translate(context),
          radius: 90,
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          textInputAction: TextInputAction.search,
          textStyle: const TextStyle(fontSize: 13),
          suffixIcon: const Icon(
            FontAwesomeIcons.magnifyingGlass,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget bodyStore() {
    return BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        print(state);
        if (state is InitState || state is StoreLoading) {
          return _buildLoading();
        }
        if (state is StoreError) {
          return Center(child: Text(state.message!));
        }
        if (state is StoreLoaded) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: state.listStore.length,
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 60),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => showStoreBottomSheet(
                  context,
                  state.listStore[index],
                ),
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.2,
                    children: [
                      SlidableAction(
                        onPressed: (context) {},
                        backgroundColor: AppColors.statusBarColor,
                        foregroundColor: const Color.fromRGBO(231, 231, 231, 1),
                        icon: FontAwesomeIcons.trash,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ],
                  ),
                  child: itemStore(state.listStore[index]),
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget itemStore(StoreResponse store) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Image.network(
              "https://www.highlandscoffee.com.vn/vnt_upload/news/02_2020/83739091_2845644318849727_1748210367038750720_o_1.png",
              height: 100,
              width: 100,
              fit: BoxFit.fitHeight,
            ),
            const SizedBox(width: 10),
            Expanded(child: infoStore(store))
          ],
        ),
      ),
    );
  }

  Widget infoStore(StoreResponse store) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          store.storeName.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
            "${store.address1} - ${store.address2} - ${store.address3} - ${store.address4}"),
        const SizedBox(height: 5),
        Row(
          children: [
            const Icon(Icons.phone),
            const SizedBox(width: 5),
            Text(store.hotlineNumber.toString()),
          ],
        ),
        const SizedBox(height: 5),
        isOpenStore(store),
      ],
    );
  }

  Widget isOpenStore(StoreResponse store) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(52, 175, 84, 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            // store.checkOpen()
            //     ? "open".translate(context):
            "close".translate(context),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text("${store.openingHour} - ${store.closingHour}"),
      ],
    );
  }
}