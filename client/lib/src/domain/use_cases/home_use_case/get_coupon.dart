import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/coupon/coupon_response.dart';
import '../../repositories/home_repository.dart';

@lazySingleton
class GetCouponUseCase
    extends UseCase<DataState<List<CouponResponse>>, dynamic> {
  GetCouponUseCase(this._repository);

  final HomeRepository _repository;

  @override
  Future<DataState<List<CouponResponse>>> call({params}) {
    return _repository.getCoupon();
  }
}
