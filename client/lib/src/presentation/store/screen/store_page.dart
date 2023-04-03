import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/domain/repositories/store/store_response.dart';
import 'package:coffee/src/presentation/signup/widgets/custom_text_input.dart';
import 'package:coffee/src/presentation/store/bloc/store_bloc.dart';
import 'package:coffee/src/presentation/store/bloc/store_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/utils/constants/constants.dart';
import '../../activity/widgets/custom_app_bar.dart';
import '../bloc/store_event.dart';
import '../widgets/bottom_sheet.dart';

class StorePage extends StatelessWidget {
  const StorePage({Key? key, this.onPress, required this.isPick, this.storeID})
      : super(key: key);

  final Function(StoreResponse store)? onPress;
  final bool isPick;
  final String? storeID;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StoreBloc>(
      create: (_) => StoreBloc()..add(FetchData()),
      child: StoreView(onPress: onPress, isPick: isPick, storeID: storeID),
    );
  }
}

class StoreView extends StatefulWidget {
  const StoreView({Key? key, this.onPress, required this.isPick, this.storeID})
      : super(key: key);

  final Function(StoreResponse store)? onPress;
  final bool isPick;
  final String? storeID;

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
      appBar: CustomAppBar(elevation: 0, isPick: widget.isPick),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            headerStore(),
            const SizedBox(height: 10),
            Expanded(child: bodyStore()),
          ],
        ),
      ),
    );
  }

  Widget headerStore() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
            padding: const EdgeInsets.symmetric(horizontal: 5),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => showStoreBottomSheet(
                  context,
                  state.listStore[index],
                  () {
                    widget.onPress!(state.listStore[index]);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
                child: itemStore(state.listStore[index]),
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
    return Stack(
      children: [
        Card(
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
        ),
        if (store.storeId == widget.storeID)
          Positioned(
            right: 5,
            bottom: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Text(
                "current_selection".translate(context),
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ),
      ],
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
