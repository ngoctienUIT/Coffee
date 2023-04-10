class Coupon {
  final String? id;
  String couponName;
  String couponCode;
  String content;
  String? imageUrl;
  String dueDate;
  double? discountRate;
  int? discountAmount;
  int? discountRateCapAmount;
  int? minimumOrderAmountCriterion;

  Coupon({
    this.id,
    required this.couponName,
    required this.couponCode,
    required this.content,
    this.imageUrl,
    required this.dueDate,
    this.discountRate,
    this.discountAmount,
    this.discountRateCapAmount,
    this.minimumOrderAmountCriterion,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": couponName,
      "code": couponCode,
      "content": content,
      "imageUrl": imageUrl,
      "dueDate": dueDate,
      "rate": discountRate,
      "capAmount": discountRateCapAmount,
      "minimumAmountCriterion": minimumOrderAmountCriterion,
      "amount": discountAmount,
    };
  }

  Coupon copyWith({
    String? couponName,
    String? dueDate,
    String? imageUrl,
    String? content,
    int? discountAmount,
    int? discountRateCapAmount,
    int? minimumOrderAmountCriterion,
    double? discountRate,
  }) {
    return Coupon(
      id: id,
      couponName: couponName ?? this.couponName,
      couponCode: couponCode,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      dueDate: dueDate ?? this.dueDate,
      discountAmount: discountAmount,
      discountRate: discountRate ?? this.discountRate,
      discountRateCapAmount:
          discountRateCapAmount ?? this.discountRateCapAmount,
      minimumOrderAmountCriterion:
          minimumOrderAmountCriterion ?? this.minimumOrderAmountCriterion,
    );
  }
}
