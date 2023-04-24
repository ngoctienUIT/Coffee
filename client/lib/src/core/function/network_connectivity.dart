import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnectivity {
  NetworkConnectivity._();
  static final _instance = NetworkConnectivity._();
  static NetworkConnectivity get instance => _instance;
  final _networkConnectivity = Connectivity();
  final _controller = StreamController.broadcast();
  ConnectivityResult? previousState;

  Stream get myStream => _controller.stream;

  void initialise() async {
    ConnectivityResult result = await _networkConnectivity.checkConnectivity();
    _checkStatus(result);
    _networkConnectivity.onConnectivityChanged.listen(_checkStatus);
  }

  void _checkStatus(ConnectivityResult result) async {
    if (previousState != null && checkChangeState(result) ||
        result == ConnectivityResult.none) {
      _controller.sink.add(result);
    }
    previousState ??= result;
  }

  bool checkChangeState(ConnectivityResult result) {
    final listInternet = [ConnectivityResult.wifi, ConnectivityResult.mobile];
    if (listInternet.contains(result) &&
            !listInternet.contains(previousState) ||
        !listInternet.contains(result) &&
            listInternet.contains(previousState)) {
      return true;
    } else {
      return false;
    }
  }

  void disposeStream() => _controller.close();
}
