import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/coupon/coupon_response.dart';
import '../../repositories/coupon_repository.dart';

@lazySingleton
class DeleteCouponUseCase extends UseCase<DataState<CouponResponse>, String> {
  final CouponRepository _repository;

  DeleteCouponUseCase(this._repository);

  @override
  Future<DataState<CouponResponse>> call({required String params}) {
    return _repository.deleteCoupon(params);
  }
}
