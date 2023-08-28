import '../../../data/models/user.dart';
import '../../../data/remote/response/product/product_response.dart';
import '../../../data/remote/response/weather/weather_response.dart';

class RecommendResponse {
  final User user;
  final List<ProductResponse> listProduct;
  final WeatherResponse? weather;
  final String? address;

  RecommendResponse({
    required this.user,
    required this.listProduct,
    this.weather,
    this.address,
  });
}
