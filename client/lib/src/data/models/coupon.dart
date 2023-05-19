import 'package:coffee/src/domain/repositories/coupon/coupon_response.dart';
import 'package:equatable/equatable.dart';

class Coupon extends Equatable {
  final String id;
  final String couponName;
  final String couponCode;
  final String content;
  final String? imageUrl;
  final String dueDate;

  const Coupon({
    required this.id,
    required this.couponName,
    required this.couponCode,
    required this.content,
    this.imageUrl,
    required this.dueDate,
  });

  factory Coupon.fromCouponResponse(CouponResponse couponResponse) {
    return Coupon(
      id: couponResponse.id,
      couponName: couponResponse.couponName,
      couponCode: couponResponse.couponCode,
      content: couponResponse.content,
      dueDate: couponResponse.dueDate,
      imageUrl: couponResponse.imageUrl,
    );
  }

  @override
  List<Object?> get props => [
        id,
        couponName,
        couponCode,
        content,
        imageUrl,
        dueDate,
      ];
}
