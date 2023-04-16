import 'package:coffee/src/core/function/custom_toast.dart';
import 'package:coffee/src/core/function/loading_animation.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
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

import '../../../core/utils/constants/constants.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key, required this.onChange}) : super(key: key);

  final VoidCallback onChange;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc()..add(GetOrderSpending()),
      child: CartView(onChange: widget.onChange),
    );
  }
}

class CartView extends StatelessWidget {
  const CartView({Key? key, required this.onChange}) : super(key: key);

  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state is GetOrderSuccessState) {
          if (state.status != null) {
            customToast(context, state.status.toString());
          }
          onChange();
          Navigator.pop(context);
        }
        if (state is GetOrderErrorState) {
          customToast(context, state.error);
          Navigator.pop(context);
        }
        if (state is GetOrderLoadingState) {
          loadingAnimation(context);
        }
        if (state is AddNoteError) {
          customToast(context, state.error);
        }
      },
      buildWhen: (previous, current) => current is GetOrderSuccessState,
      builder: (context, state) {
        print("cart page: $state");
        if (state is GetOrderSuccessState) {
          if (state.order == null) {
            return emptyCart(context);
          } else {
            Address? address;
            if (state.order!.address1 != null) {
              address = Address(
                province: state.order!.address4!,
                district: state.order!.address3!,
                ward: state.order!.address2!,
                address: state.order!.address1!,
              );
            }
            return Scaffold(
              backgroundColor: AppColors.bgColor,
              appBar: AppBarCart(
                clearCart: () => _showAlertDialog(context, () {
                  context.read<CartBloc>().add(DeleteOrderEvent());
                }),
              ),
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
                        selectedPickupOption:
                            state.order!.selectedPickupOption!,
                      ),
                      const SizedBox(height: 10),
                      ListProduct(
                        orderItems: state.order!.orderItems == null
                            ? []
                            : state.order!.orderItems!,
                        onChange: (total) {},
                      ),
                      const SizedBox(height: 10),
                      AddCoupons(
                        coupons: state.order!.appliedCoupon,
                        onDelete: () {
                          context.read<CartBloc>().add(DeleteCouponOrder());
                        },
                        onPress: (id) {
                          context.read<CartBloc>().add(AttachCouponToOrder(id));
                        },
                      ),
                      const SizedBox(height: 10),
                      TotalPayment(order: state.order!),
                      const SizedBox(height: 10),
                      const PaymentMethods(),
                      const SizedBox(height: 200),
                    ],
                  ),
                ),
              ),
              bottomSheet: BottomCartPage(order: state.order!),
            );
          }
        }
        return Scaffold(body: Container());
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

  Future _showAlertDialog(BuildContext context, VoidCallback okPress) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Xác nhận"),
          content: const Text(
              "Bạn có muốn xóa tất cả các mục trong giỏ hàng của bạn?"),
          actions: [
            TextButton(
              child: Text('cancel'.translate(context)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: () {
                okPress();
                Navigator.pop(context);
              },
              child: Text('ok'.translate(context)),
            ),
          ],
        );
      },
    );
  }
}
