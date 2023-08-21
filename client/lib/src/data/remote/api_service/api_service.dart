import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../response/user/user_response.dart';
import '../response/coupon/coupon_response.dart';
import '../response/login/login_response.dart';
import '../response/order/order_response.dart';
import '../response/product/product_response.dart';
import '../response/product_catalogues/product_catalogues_response.dart';
import '../response/store/store_response.dart';
import '../response/tag/tag_response.dart';
import '../response/topping/topping_response.dart';
import '../response/weather/weather_response.dart';

part 'api_service.g.dart';

//flutter pub run build_runner build
// flutter pub run build_runner build --delete-conflicting-outputs
@RestApi(baseUrl: 'http://192.168.1.219:8080')
// @RestApi(baseUrl: 'http://34.87.121.133:8080')
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  //sign up
  @POST("/user/signup")
  Future<HttpResponse<UserResponse>> signup(@Body() Map<String, dynamic> user);

  //login
  @POST("/user/oauth2/login")
  Future<HttpResponse<LoginResponse>> loginCredentialTokenOAuth2(
      @Body() Map<String, dynamic> user);

  @POST("/user/oauth2/link")
  Future<HttpResponse> linkAccountWithOAuth2Provider(
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> user,
  );

  @POST("/user/oauth2/unlink?userId={id}&providerName=GOOGLE")
  Future<HttpResponse> unlinkAccountWithOAuth2Provider(
    @Header('Authorization') String token,
    @Path("id") String id,
  );

  //login
  @POST("/user/login")
  Future<HttpResponse<LoginResponse>> login(@Body() Map<String, dynamic> user);

  // Reset password
  @GET("/user/issue-rspwmail?email={email}")
  Future<HttpResponse<String>> resetPasswordIssue(@Path("email") String email);

  @POST("/user/validate-reset-token?resetCredential={token}")
  Future<HttpResponse<bool>> validateResetTokenClient(
    @Path("token") String token,
    @Body() String text,
  );

  @POST("/user/reset-pass?resetCredential={token}")
  Future<HttpResponse<UserResponse>> issueNewPasswordUser(
    @Path("token") String token,
    @Body() String text,
  );

  // Update existing user's field
  @POST("/user/{email}/{field}")
  Future<HttpResponse<UserResponse>> updateUserField(
    @Header('Authorization') String token,
    @Path("email") String email,
    @Path("field") String field,
    @Body() dynamic body,
  );

  @POST("/user/{email}")
  Future<HttpResponse<UserResponse>> updateExistingUser(
    @Header('Authorization') String token,
    @Path("email") String email,
    @Body() Map<String, dynamic> body,
  );

  // remove user by ID
  @DELETE("/user/{id}")
  Future<HttpResponse> removeUserByID(
    @Header('Authorization') String token,
    @Path("id") String id,
  );

  // Get user by ID
  @GET("/user/{id}")
  Future<HttpResponse<UserResponse>> getUserByID(
    @Header('Authorization') String token,
    @Path("id") String id,
  );

  //product
  @GET('/product')
  Future<HttpResponse<List<ProductResponse>>> getAllProducts();

  @GET('/product/{id}')
  Future<HttpResponse<ProductResponse>> getProductByID(@Path("id") String id);

  @GET('/product/search?q={query}')
  Future<HttpResponse<List<ProductResponse>>> searchProductsByName(
      @Path("query") String query);

  //product-catalogues
  @GET('/product-catalogues')
  Future<HttpResponse<List<ProductCataloguesResponse>>>
      getAllProductCatalogues();

  @GET('/product-catalogues/{id}')
  Future<HttpResponse<ProductCataloguesResponse>> getProductCatalogueByID(
      @Path("id") String id);

  @GET('/product-catalogues/search?q={query}')
  Future<HttpResponse<List<ProductCataloguesResponse>>>
      searchProductCataloguesByName(@Path("query") String query);

  @GET('/product-catalogues/{id}/products')
  Future<HttpResponse<List<ProductResponse>>>
      getAllProductsFromProductCatalogueID(@Path("id") String id);

  //coupon
  @GET('/coupon')
  Future<HttpResponse<List<CouponResponse>>> getAllCoupons();

  @GET('/coupon/available/{userId}')
  Future<HttpResponse<List<CouponResponse>>> getAvailableCoupons(
      @Path('userId') id);

  @GET('/coupon/{id}')
  Future<HttpResponse<CouponResponse>> getCouponByID(@Path("id") String id);

  @GET('/coupon/search?q={query}')
  Future<HttpResponse<List<CouponResponse>>> searchCouponsByName(
      @Path("query") String query);

  //stores
  @GET('/stores')
  Future<HttpResponse<List<StoreResponse>>> getAllStores();

  @GET('/stores/{id}')
  Future<HttpResponse<StoreResponse>> getStoreByID(@Path("id") String id);

  @GET('/stores/search?q={query}')
  Future<HttpResponse<List<StoreResponse>>> searchStoresByName(
      @Path("query") String query);

  //tag
  @GET('/tag')
  Future<HttpResponse<List<TagResponse>>> getAllTags();

  @GET('/tag/{id}')
  Future<HttpResponse<TagResponse>> getTagByID(@Path("id") String id);

  //topping
  @GET('/topping')
  Future<HttpResponse<List<ToppingResponse>>> getAllToppings();

  @GET('/topping/{id}')
  Future<HttpResponse<ToppingResponse>> getToppingByID(@Path("id") String id);

  //order
  @GET("/order?userIdentity={email}&status={status}")
  Future<HttpResponse<List<OrderResponse>>> getAllOrders(
    @Header('Authorization') String token,
    @Path("email") String email,
    @Path("status") String status,
  );

  @GET("/order/{id}")
  Future<HttpResponse<OrderResponse>> getOrderByID(
    @Header('Authorization') String token,
    @Path("id") String id,
  );

  // 'Bearer $token'
  @POST("/order")
  Future<HttpResponse<OrderResponse>> createNewOrder(
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> order,
  );

  @POST("/order/{id}")
  Future<HttpResponse<OrderResponse>> updatePendingOrder(
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> order,
    @Path("id") String id,
  );

  @POST("/order/{id}/coupons")
  Future<HttpResponse<OrderResponse>> attachCouponToOrder(
    @Header('Authorization') String token,
    @Body() String couponID,
    @Path("id") String id,
  );

  @DELETE("/order/{id}")
  Future<HttpResponse<OrderResponse>> cancelOrder(
    @Header('Authorization') String token,
    @Path("id") String id,
  );

  @POST("/order/{id}/place-order")
  Future<HttpResponse<OrderResponse>> placeOrder(
    @Header('Authorization') String token,
    @Path("id") String id,
  );

  @DELETE("/order/truncate-cart?userIdentity={email}")
  Future<HttpResponse<OrderResponse>> removePendingOrder(
    @Header('Authorization') String token,
    @Path("email") String email,
  );

  @GET("/recommendation/weather?lon={lon}&lat={lat}")
  Future<HttpResponse<WeatherResponse>> weatherRecommendations(
    @Path('lon') double long,
    @Path('lat') double lat,
  );

  @GET("/recommendation?lon={lon}&lat={lat}")
  Future<HttpResponse<List<ProductResponse>>> recommendation(
    @Path('lon') double long,
    @Path('lat') double lat,
  );
}
