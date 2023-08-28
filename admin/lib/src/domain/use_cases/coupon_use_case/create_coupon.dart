import 'package:coffee_admin/src/core/request/coupon_request/coupon_request.dart';
import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/coupon/coupon_response.dart';
import '../../repositories/coupon_repository.dart';

@lazySingleton
class CreateCouponUseCase
    extends UseCase<DataState<CouponResponse>, CouponRequest> {
  final CouponRepository _repository;

  CreateCouponUseCase(this._repository);

  @override
  Future<DataState<CouponResponse>> call({required CouponRequest params}) {
    return _repository.createCoupon(params);
  }

}