import 'package:coffee/src/data/models/address.dart';
import 'package:coffee/src/presentation/cart/bloc/cart_bloc.dart';
import 'package:coffee/src/presentation/cart/bloc/cart_event.dart';
import 'package:coffee/src/presentation/cart/bloc/cart_state.dart';
import 'package:coffee/src/presentation/cart/widgets/add_coupons.dart';
import 'package:coffee/src/presentation/cart/widgets/app_bar_cart.dart';
import 'package:coffee/src/presentation/cart/widgets/bottom_cart_page.dart';
import 'package:coffee/src/presentation/cart/widgets/info_cart.dart';
import 'package:coffee/src/presentation/cart/widgets/list_product.dart';
import 'package:coffee/src/presentation/cart/widgets/payment_methods.dart';
import 'package:coffee/src/presentation/cart/widgets/total_payment.dart';
import 'package:coffee/src/presentation/login/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/utils/constants/constants.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key, required this.onRemove}) : super(key: key);

  final VoidCallback onRemove;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc()..add(GetOrderSpending()),
      child: CartView(onRemove: widget.onRemove),
    );
  }
}

class CartView extends StatelessWidget {
  const CartView({Key? key, required this.onRemove}) : super(key: key);

  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state is RemoveOrderSuccessState) {
          onRemove();
          Navigator.pop(context);
        }
        if (state is DeleteProductSuccessState) {
          context.read<CartBloc>().add(GetOrderSpending());
        }
        if (state is PlaceOrderSuccessState) {
          Fluttertoast.showToast(msg: "Đặt hàng thành công");
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        print("cart page: $state");
        if (state is InitState || state is GetOrderLoadingState) {
          return _buildLoading();
        }
        if (state is GetOrderErrorState) {
          return Center(child: Text(state.error));
        }
        if (state is GetOrderSuccessState) {
          if (state.order == null) {
            return emptyCart(context);
          } else {
            Address? address;
            if (state.order!.address1 != null) {
              address = Address(
                address: state.order!.address1!,
                phone: "",
                name: "",
                country: "Việt Nam",
                province: state.order!.address4!,
                district: state.order!.address3!,
                ward: state.order!.address2!,
              );
            }
            return Scaffold(
              backgroundColor: AppColors.bgColor,
              appBar: AppBarCart(clearCart: () {
                context.read<CartBloc>().add(DeleteOrderEvent());
              }),
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      InfoCart(
                        store: state.order!.selectedPickupStore,
                        address: address,
                        note: state.order!.orderCustomerNote,
                      ),
                      const SizedBox(height: 10),
                      ListProduct(
                        orderItems: state.order!.orderItems == null
                            ? []
                            : state.order!.orderItems!,
                        onChange: (total) {},
                      ),
                      const SizedBox(height: 10),
                      AddCoupons(coupons: state.order!.appliedCoupons),
                      const SizedBox(height: 10),
                      TotalPayment(order: state.order!),
                      const SizedBox(height: 10),
                      const PaymentMethods(),
                      const SizedBox(height: 200),
                    ],
                  ),
                ),
              ),
              bottomSheet: BottomCartPage(total: state.order!.orderAmount!),
            );
          }
        }
        return Container();
      },
    );
  }

  Widget emptyCart(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          "Giỏ hàng của bạn đang trống",
          style: TextStyle(fontSize: 16),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(10),
        child: customButton(
          text: "ĐẶT HÀNG NGAY",
          isOnPress: true,
          onPress: () => Navigator.pop(context),
        ),
      ),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
