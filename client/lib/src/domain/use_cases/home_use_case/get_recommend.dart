import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../core/resources/request_state.dart';
import '../../../core/response/home_response/recommend_response.dart';
import '../../repositories/home_repository.dart';

@lazySingleton
class GetRecommendUseCase
    extends UseCase<DataState<RecommendResponse>, dynamic> {
  GetRecommendUseCase(this._repository);

  final HomeRepository _repository;

  @override
  Future<DataState<RecommendResponse>> call({params}) async {
    return _repository.getRecommend(await _getCurrentPosition());
  }

  Future<RequestState<bool>> _handleLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return RequestState(false, 'Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return RequestState(
        false,
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      bool check = await Geolocator.openLocationSettings();
      if (!check) {
        return RequestState(
          false,
          'Location services are disabled. Please enable the services',
        );
      }
    }
    return RequestState(true);
  }

  Future<RequestState<Position?>> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    Position? position;
    if (!hasPermission.state) return RequestState(null, hasPermission.error);
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position myPosition) {
      position = myPosition;
    }).catchError((e) {
      print(e);
    });
    return RequestState(position, hasPermission.error);
  }
}
