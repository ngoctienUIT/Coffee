import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../data/remote/response/coupon/coupon_response.dart';
import '../../repositories/coupon_repository.dart';

@lazySingleton
class GetAllCouponUseCase
    extends UseCase<DataState<List<CouponResponse>>, dynamic> {
  final CouponRepository _repository;

  GetAllCouponUseCase(this._repository);

  @override
  Future<DataState<List<CouponResponse>>> call({params}) {
    return _repository.getAllCoupon();
  }
}
