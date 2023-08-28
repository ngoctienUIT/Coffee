import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/request/coupon_request/coupon_request.dart';
import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/coupon/coupon_response.dart';
import '../../repositories/coupon_repository.dart';

@lazySingleton
class UpdateCouponUseCase
    extends UseCase<DataState<CouponResponse>, CouponRequest> {
  final CouponRepository _repository;

  UpdateCouponUseCase(this._repository);

  @override
  Future<DataState<CouponResponse>> call({required CouponRequest params}) {
    return _repository.updateCoupon(params);
  }
}
