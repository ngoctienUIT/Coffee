import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/preferences_model.dart';
import 'coupon_event.dart';
import 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  PreferencesModel preferencesModel;

  CouponBloc(this.preferencesModel) : super(InitState()) {
    on<FetchData>((event, emit) => fetchData(emit));
  }

  Future fetchData(Emitter emit) async {
    try {
      emit(CouponLoading());
      final response = await preferencesModel.apiService
          .getAvailableCoupons(preferencesModel.user!.id);
      emit(CouponLoaded(response.data
          .where((element) =>
              element.dueDate.toDate().difference(DateTime.now()).inSeconds >=
              0)
          .toList()));
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(CouponError(error));
      print(error);
    } catch (e) {
      emit(CouponError(e.toString()));
      print(e);
    }
  }
}
