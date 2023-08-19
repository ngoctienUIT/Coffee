import 'package:coffee/src/data/models/preferences_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../../data/remote/response/order/order_response.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  PreferencesModel preferencesModel;

  HomeBloc(this.preferencesModel) : super(InitState()) {
    on<FetchData>((event, emit) => getData(event.check, emit));

    on<GetCouponEvent>((event, emit) => getCoupon(emit));

    on<GetOrderSpendingEvent>((event, emit) => getOrderSpending(emit));

    on<ChangeBannerEvent>((event, emit) => emit(ChangeBannerState()));
  }

  Future<bool> _handleLocationPermission(Emitter emit) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(HomeError('Location permissions are denied'));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      emit(HomeError(
          'Location permissions are permanently denied, we cannot request permissions.'));
      return false;
    }
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      bool check = await Geolocator.openLocationSettings();
      if (!check) {
        emit(HomeError(
            'Location services are disabled. Please enable the services'));
        return false;
      }
    }
    return true;
  }

  Future<Position?> _getCurrentPosition(Emitter emit) async {
    final hasPermission = await _handleLocationPermission(emit);
    Position? position;
    if (!hasPermission) return null;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position myPosition) {
      _getAddressFromLatLng(myPosition);
      position = myPosition;
    }).catchError((e) {
      print(e);
    });
    return position;
  }

  Future<String?> _getAddressFromLatLng(Position position) async {
    String? address;
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      print(place.toJson());
      address =
          '${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}';
      print(address);
    }).catchError((e) {
      print(e);
    });
    return address;
  }

  Future getData(bool check, Emitter emit) async {
    try {
      emit(HomeLoading(check));
      Position? position = await _getCurrentPosition(emit);
      print("position ${position?.toJson()}");
      if (position != null) {
        final weather = preferencesModel.apiService
            .weatherRecommendations(position.longitude, position.latitude);
        final listProduct = preferencesModel.apiService
            .recommendation(position.longitude, position.latitude);

        emit(HomeLoaded(
          user: preferencesModel.user!,
          listProduct: (await listProduct).data,
          weather: (await weather).data,
          address: await _getAddressFromLatLng(position),
        ));
      } else {
        final listProduct = preferencesModel.apiService.getAllProducts();
        emit(HomeLoaded(
          user: preferencesModel.user!,
          listProduct: (await listProduct).data,
        ));
      }
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(HomeError(error));
      print(error);
    } catch (e) {
      emit(HomeError(e.toString()));
      print(e);
    }
  }

  Future getOrderSpending(Emitter emit) async {
    try {
      final response = await preferencesModel.apiService.getAllOrders(
        "Bearer ${preferencesModel.token}",
        preferencesModel.user!.username,
        "PENDING",
      );
      OrderResponse? myOrder = response.data.isEmpty ? null : response.data[0];
      emit(CartLoaded(myOrder));
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(HomeError(error));
      print(error);
    } catch (e) {
      emit(HomeError(e.toString()));
      print(e);
    }
  }

  Future getCoupon(Emitter emit) async {
    try {
      final listCoupon = await preferencesModel.apiService.getAllCoupons();
      emit(CouponLoaded(listCoupon: listCoupon.data));
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      emit(HomeError(error));
      print(error);
    } catch (e) {
      emit(HomeError(e.toString()));
      print(e);
    }
  }
}
