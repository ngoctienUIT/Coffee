import 'package:coffee/src/domain/repositories/login/login_response.dart';
import 'package:coffee/src/domain/repositories/order/order_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import 'entities/user/user_response.dart';
import 'repositories/coupon/coupon_response.dart';
import 'repositories/product/product_response.dart';
import 'repositories/product_catalogues/product_catalogues_response.dart';
import 'repositories/store/store_response.dart';
import 'repositories/tag/tag_response.dart';
import 'repositories/topping/topping_response.dart';

part 'api_service.g.dart';

// @RestApi(baseUrl: 'http://192.168.1.219:8080')
@RestApi(baseUrl: 'http://34.87.121.133:8080')
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  //sign up
  @POST("/user/signup")
  Future<UserResponse> signup(@Body() Map<String, dynamic> user);

  //login
  @POST("/user/login")
  Future<LoginResponse> login(@Body() Map<String, dynamic> user);

  // Reset password
  @GET(
      "/user/issue-rspwmail?email={email}&forward=http://mock-client.com/reset-password.jsp")
  Future resetPassword(@Path("email") String email);

  // Update existing user's field
  @POST("/user/{email}/{field}")
  Future<UserResponse> updateUser(
      @Path("email") String email, @Path("field") String field, @Body() body);

  // Get user by ID
  @DELETE("/user/{id}")
  Future removeUserByID(@Path("id") String id);

  // Remove user by ID
  @GET("/user/{id}")
  Future<UserResponse> getUserByID(@Path("id") String id);

  //product
  @GET('/product')
  Future<List<ProductResponse>> getAllProducts();

  @GET('/product/{id}')
  Future<ProductResponse> getProductByID(@Path("id") String id);

  @GET('/product/search?q={query}')
  Future<List<ProductResponse>> searchProductsByName(
      @Path("query") String query);

  //product-catalogues
  @GET('/product-catalogues')
  Future<List<ProductCataloguesResponse>> getAllProductCatalogues();

  @GET('/product-catalogues/{id}')
  Future<ProductCataloguesResponse> getProductCatalogueByID(
      @Path("id") String id);

  @GET('/product-catalogues/search?q={query}')
  Future<List<ProductCataloguesResponse>> searchProductCataloguesByName(
      @Path("query") String query);

  //coupon
  @GET('/coupon')
  Future<List<CouponResponse>> getAllCoupons();

  @GET('/coupon/{id}')
  Future<CouponResponse> getCouponByID(@Path("id") String id);

  @GET('/coupon/search?q={query}')
  Future<List<CouponResponse>> searchCouponsByName(@Path("query") String query);

  //stores
  @GET('/stores')
  Future<List<StoreResponse>> getAllStores();

  @GET('/stores/{id}')
  Future<StoreResponse> getStoreByID(@Path("id") String id);

  @GET('/stores/search?q={query}')
  Future<List<StoreResponse>> searchStoresByName(@Path("query") String query);

  //tag
  @GET('/tag')
  Future<List<TagResponse>> getAllTags();

  @GET('/tag/{id}')
  Future<TagResponse> getTagByID(@Path("id") String id);

  //topping
  @GET('/topping')
  Future<List<ToppingResponse>> getAllToppings();

  @GET('/topping/{id}')
  Future<ToppingResponse> getToppingByID(@Path("id") String id);

  //order
  @GET("/order?userIdentity={email}&status=")
  Future<List<OrderResponse>> getOrderHistoryCustomer(
      @Path("email") String email);

  @GET("/order?order?userIdentity={email}&status=PENDING")
  Future<List<OrderResponse>> getPendingOrderCustomer(
      @Path("email") String email);

  @GET("/order/{id}")
  Future<OrderResponse> getOrderByID(@Path("id") String id);

  @POST("/order}")
  Future<OrderResponse> createNewOrder(@Body() Map<String, dynamic> order);
}
