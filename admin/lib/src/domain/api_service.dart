import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import 'entities/user/user_response.dart';
import 'repositories/coupon/coupon_response.dart';
import 'repositories/login/login_response.dart';
import 'repositories/order/order_response.dart';
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
  Future<UserResponse> updateUserField(
    @Header('Authorization') String token,
    @Path("email") String email,
    @Path("field") String field,
    @Body() user,
  );

  // Get user by ID
  @DELETE("/user/{id}")
  Future removeUserByID(@Path("id") String id);

  // Remove user by ID
  @GET("/user/{id}")
  Future<UserResponse> getUserByID(@Path("id") String id);

  @GET("/user")
  Future<UserResponse> getAllUsers(@Header('Authorization') String token);

  @GET("/user/search/name?q={name}")
  Future<UserResponse> searchUserByName(@Path("name") String name);

  //product
  @GET('/product')
  Future<List<ProductResponse>> getAllProducts();

  @GET('/product/{id}')
  Future<ProductResponse> getProductByID(@Path("id") String id);

  @GET('/product/search?q={query}')
  Future<List<ProductResponse>> searchProductsByName(
      @Path("query") String query);

  @POST('/product')
  Future<ProductResponse> createNewProduct(
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> product,
  );

  @POST('/product/{id}')
  Future<ProductResponse> updateExistingProducts(
    @Path("id") String id,
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> product,
  );

  @POST('/product/{id}/{field}')
  Future<ProductResponse> updateProductFieldValue(
    @Path("id") String id,
    @Path("field") String field,
    @Body() dynamic fieldValue,
  );

  @POST('/product/{id}/topping-options')
  Future<ProductResponse> updateProductToppingOptions(@Path("id") String id);

  @DELETE('/product/{id}')
  Future<ProductResponse> removeProductByID(@Path("id") String id);

  //product-catalogues
  @GET('/product-catalogues')
  Future<List<ProductCataloguesResponse>> getAllProductCatalogues();

  @GET('/product-catalogues/{id}')
  Future<ProductCataloguesResponse> getProductCatalogueByID(
      @Path("id") String id);

  @GET('/product-catalogues/search?q={query}')
  Future<List<ProductCataloguesResponse>> searchProductCataloguesByName(
      @Path("query") String query);

  @GET('/product-catalogues/{id}/products')
  Future<List<ProductCataloguesResponse>> getAllProductsFromProductCatalogueID(
      @Path("id") String id);

  @POST('/product-catalogues')
  Future<ProductCataloguesResponse> createNewProductCatalogue(
      @Body() Map<String, dynamic> productCatalogues);

  @POST('/product-catalogues/{id}')
  Future<ProductCataloguesResponse> updateExistingProductCatalogue(
    @Body() Map<String, dynamic> productCatalogues,
    @Path("id") String id,
  );

  @POST('/product-catalogues/{id}/{field}')
  Future<ProductCataloguesResponse> updateProductCatalogueFieldValue(
    @Body() dynamic fieldValue,
    @Path("id") String id,
    @Path("field") String field,
  );

  @POST('/product-catalogues/{id}/sub-catalogues')
  Future<ProductCataloguesResponse> updateSubCatalogueUsingID(
    @Body() List<String> listSub,
    @Path("id") String id,
  );

  @DELETE('/product-catalogues/{id}')
  Future<ProductCataloguesResponse> removeProductCataloguesByID(
      @Path("id") String id);

  //coupon
  @GET('/coupon')
  Future<List<CouponResponse>> getAllCoupons();

  @GET('/coupon/{id}')
  Future<CouponResponse> getCouponByID(@Path("id") String id);

  @GET('/coupon/search?q={query}')
  Future<List<CouponResponse>> searchCouponsByName(@Path("query") String query);

  @POST('/coupon')
  Future<CouponResponse> createNewCoupon(@Body() Map<String, dynamic> coupon);

  @POST('/coupon/{id}')
  Future<CouponResponse> updateExistingCoupon(
    @Path("id") String id,
    @Body() Map<String, dynamic> coupon,
  );

  @POST('/coupon/{id}/{field}')
  Future<CouponResponse> updateCouponFieldValue(
    @Path("id") String id,
    @Path("field") String field,
    @Body() dynamic fieldValue,
  );

  @POST('/coupon/{id}/{field}')
  Future<CouponResponse> removeCouponByID(
    @Path("id") String id,
    @Path("field") String field,
    @Body() Map<String, dynamic> coupon,
  );

  //stores
  @GET('/stores')
  Future<List<StoreResponse>> getAllStores();

  @GET('/stores/{id}')
  Future<StoreResponse> getStoreByID(@Path("id") String id);

  @GET('/stores/search?q={query}')
  Future<List<StoreResponse>> searchStoresByName(@Path("query") String query);

  @POST('/stores')
  Future<StoreResponse> registerNewStore(@Body() Map<String, dynamic> store);

  @POST('/stores/{id}')
  Future<StoreResponse> updateExistingStore(
    @Path("id") String id,
    @Body() Map<String, dynamic> store,
  );

  @POST('/stores/{id}/{field}')
  Future<StoreResponse> updateStoreFieldValue(
    @Path("id") String id,
    @Path("field") String field,
    @Body() dynamic fieldValue,
  );

  @DELETE('/stores/{id}')
  Future<StoreResponse> removeStoreByID(
    @Path("id") String id,
    @Header('Authorization') String token,
  );

  //tag
  @GET('/tag')
  Future<List<TagResponse>> getAllTags();

  @GET('/tag/{id}')
  Future<TagResponse> getTagByID(@Path("id") String id);

  @POST('/tag')
  Future<TagResponse> createNewTag(@Body() Map<String, dynamic> tag);

  @POST('/tag/{id}')
  Future<TagResponse> updateExistingTag(
    @Body() Map<String, dynamic> tag,
    @Path("id") String id,
  );

  @POST('/tag/{id}/{field}')
  Future<TagResponse> updateTagFieldValue(
    @Body() dynamic fieldValue,
    @Path("id") String id,
    @Path("field") String field,
  );

  @DELETE('/tag/{id}')
  Future<TagResponse> removeByID(@Path("id") String id);

  //topping
  @GET('/topping')
  Future<List<ToppingResponse>> getAllToppings();

  @GET('/topping/{id}')
  Future<ToppingResponse> getToppingByID(@Path("id") String id);

  @POST('/topping')
  Future<ToppingResponse> createNewTopping(
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> topping,
  );

  @POST('/topping/{id}')
  Future<ToppingResponse> updateExistingTopping(
    @Path("id") String id,
    @Body() Map<String, dynamic> topping,
  );

  @POST('/topping/{id}/{field}')
  Future<ToppingResponse> updateToppingFieldValue(
    @Path("id") String id,
    @Path("field") String field,
    @Body() dynamic fieldValue,
  );

  @DELETE('/topping/{id}')
  Future<ToppingResponse> removeToppingByID(@Path("id") String id);

  //order
  @GET("/order?userIdentity={email}&status=")
  Future<List<OrderResponse>> getOrderHistoryCustomer(
    @Header('Authorization') String token,
    @Path("email") String email,
  );

  @GET("/order?order?userIdentity={email}&status=PENDING")
  Future<List<OrderResponse>> getPendingOrderCustomer(
    @Header('Authorization') String token,
    @Path("email") String email,
  );

  @GET("/order/{id}")
  Future<OrderResponse> getOrderByID(
    @Header('Authorization') String token,
    @Path("id") String id,
  );

  // 'Bearer $token'
  @POST("/order}")
  Future<OrderResponse> createNewOrder(
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> order,
  );

  @POST("/order/{id}/place-order")
  Future<OrderResponse> placeOrder(
    @Header('Authorization') String token,
    @Path("id") String id,
  );

  @POST("/order/{id}/close")
  Future<OrderResponse> closeSuccessOrder(
    @Header('Authorization') String token,
    @Path("id") String id,
  );

  @POST("/order/{id}")
  Future<OrderResponse> cancelOrder(
    @Header('Authorization') String token,
    @Path("id") String id,
  );

  @POST("/order/{id}/attach/{coupon_id}")
  Future<OrderResponse> attachCouponToOrder(
    @Header('Authorization') String token,
    @Path("id") String id,
    @Path("coupon_id") String couponID,
  );
}
