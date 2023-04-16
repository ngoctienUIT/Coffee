import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

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
  Future<HttpResponse<UserResponse>> signup(@Body() Map<String, dynamic> user);

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

  @POST("/user/{email}")
  Future<HttpResponse<UserResponse>> updateExistingUser(
    @Header('Authorization') String token,
    @Path("email") String email,
    @Body() Map<String, dynamic> body,
  );

  // Update existing user's field
  @POST("/user/{email}/{field}")
  Future<HttpResponse<UserResponse>> updateUserField(
    @Header('Authorization') String token,
    @Path("email") String email,
    @Path("field") String field,
    @Body() user,
  );

  // Get user by ID
  @DELETE("/user/{id}")
  Future<HttpResponse> removeUserByID(
    @Header('Authorization') String token,
    @Path("id") String id,
  );

  // Remove user by ID
  @GET("/user/{id}")
  Future<HttpResponse<UserResponse>> getUserByID(
      @Header('Authorization') String token, @Path("id") String id);

  @GET("/user")
  Future<HttpResponse<List<UserResponse>>> getAllUsers(
      @Header('Authorization') String token);

  @GET("/user/search/name?q={name}")
  Future<HttpResponse<List<UserResponse>>> searchUserByName(
      @Path("name") String name);

  //product
  @GET('/product')
  Future<HttpResponse<List<ProductResponse>>> getAllProducts();

  @GET('/product/{id}')
  Future<HttpResponse<ProductResponse>> getProductByID(@Path("id") String id);

  @GET('/product/search?q={query}')
  Future<HttpResponse<List<ProductResponse>>> searchProductsByName(
      @Path("query") String query);

  @POST('/product')
  Future<HttpResponse<ProductResponse>> createNewProduct(
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> product,
  );

  @POST('/product/{id}')
  Future<HttpResponse<ProductResponse>> updateExistingProducts(
    @Path("id") String id,
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> product,
  );

  @POST('/product/{id}/{field}')
  Future<HttpResponse<ProductResponse>> updateProductFieldValue(
    @Path("id") String id,
    @Path("field") String field,
    @Body() dynamic fieldValue,
  );

  @POST('/product/{id}/topping-options')
  Future<HttpResponse<ProductResponse>> updateProductToppingOptions(
      @Path("id") String id);

  @DELETE('/product/{id}')
  Future<HttpResponse<ProductResponse>> removeProductByID(
      @Header("Authorization") token, @Path("id") String id);

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

  @POST('/product-catalogues')
  Future<HttpResponse<ProductCataloguesResponse>> createNewProductCatalogue(
      @Header("Authorization") token,
      @Body() Map<String, dynamic> productCatalogues);

  @POST('/product-catalogues/{id}')
  Future<HttpResponse<ProductCataloguesResponse>>
      updateExistingProductCatalogue(
    @Header("Authorization") token,
    @Body() Map<String, dynamic> productCatalogues,
    @Path("id") String id,
  );

  @POST('/product-catalogues/{id}/products')
  Future<HttpResponse<ProductCataloguesResponse>>
      updateProductIdsProductCatalogues(
    @Header("Authorization") token,
    @Body() List<String> list,
    @Path("id") String id,
  );

  @POST('/product-catalogues/{id}/{field}')
  Future<HttpResponse<ProductCataloguesResponse>>
      updateProductCatalogueFieldValue(
    @Body() dynamic fieldValue,
    @Path("id") String id,
    @Path("field") String field,
  );

  @POST('/product-catalogues/{id}/sub-catalogues')
  Future<HttpResponse<ProductCataloguesResponse>> updateSubCatalogueUsingID(
    @Body() List<String> listSub,
    @Path("id") String id,
  );

  @DELETE('/product-catalogues/{id}')
  Future<HttpResponse<ProductCataloguesResponse>> removeProductCataloguesByID(
    @Header("Authorization") token,
    @Path("id") String id,
  );

  //coupon
  @GET('/coupon')
  Future<HttpResponse<List<CouponResponse>>> getAllCoupons();

  @GET('/coupon/{id}')
  Future<HttpResponse<CouponResponse>> getCouponByID(@Path("id") String id);

  @GET('/coupon/search?q={query}')
  Future<HttpResponse<List<CouponResponse>>> searchCouponsByName(
      @Path("query") String query);

  @POST('/coupon')
  Future<HttpResponse<CouponResponse>> createNewCoupon(
    @Header("Authorization") token,
    @Body() Map<String, dynamic> coupon,
  );

  @POST('/coupon/{id}')
  Future<HttpResponse<CouponResponse>> updateExistingCoupon(
    @Path("id") String id,
    @Header("Authorization") token,
    @Body() Map<String, dynamic> coupon,
  );

  @POST('/coupon/{id}/{field}')
  Future<HttpResponse<CouponResponse>> updateCouponFieldValue(
    @Path("id") String id,
    @Path("field") String field,
    @Body() dynamic fieldValue,
  );

  @DELETE('/coupon/{id}')
  Future<HttpResponse<CouponResponse>> removeCouponByID(
    @Path("id") String id,
    @Header("Authorization") token,
  );

  //stores
  @GET('/stores')
  Future<HttpResponse<List<StoreResponse>>> getAllStores();

  @GET('/stores/{id}')
  Future<HttpResponse<StoreResponse>> getStoreByID(@Path("id") String id);

  @GET('/stores/search?q={query}')
  Future<HttpResponse<List<StoreResponse>>> searchStoresByName(
      @Path("query") String query);

  @POST('/stores')
  Future<HttpResponse<StoreResponse>> registerNewStore(
    @Header("Authorization") token,
    @Body() Map<String, dynamic> store,
  );

  @POST('/stores/{id}')
  Future<HttpResponse<StoreResponse>> updateExistingStore(
    @Path("id") String id,
    @Header("Authorization") token,
    @Body() Map<String, dynamic> store,
  );

  @POST('/stores/{id}/{field}')
  Future<HttpResponse<StoreResponse>> updateStoreFieldValue(
    @Path("id") String id,
    @Path("field") String field,
    @Header("Authorization") token,
    @Body() dynamic fieldValue,
  );

  @DELETE('/stores/{id}')
  Future<HttpResponse<StoreResponse>> removeStoreByID(
    @Path("id") String id,
    @Header('Authorization') String token,
  );

  //tag
  @GET('/tag')
  Future<HttpResponse<List<TagResponse>>> getAllTags();

  @GET('/tag/{id}')
  Future<HttpResponse<TagResponse>> getTagByID(@Path("id") String id);

  @POST('/tag')
  Future<HttpResponse<TagResponse>> createNewTag(
    @Header("Authorization") token,
    @Body() Map<String, dynamic> tag,
  );

  @POST('/tag/{id}')
  Future<HttpResponse<TagResponse>> updateExistingTag(
    @Header("Authorization") token,
    @Body() Map<String, dynamic> tag,
    @Path("id") String id,
  );

  @POST('/tag/{id}/{field}')
  Future<HttpResponse<TagResponse>> updateTagFieldValue(
    @Header("Authorization") token,
    @Body() dynamic fieldValue,
    @Path("id") String id,
    @Path("field") String field,
  );

  @DELETE('/tag/{id}')
  Future<HttpResponse<TagResponse>> removeTagByID(
    @Header("Authorization") token,
    @Path("id") String id,
  );

  //topping
  @GET('/topping')
  Future<HttpResponse<List<ToppingResponse>>> getAllToppings();

  @GET('/topping/{id}')
  Future<HttpResponse<ToppingResponse>> getToppingByID(@Path("id") String id);

  @POST('/topping')
  Future<HttpResponse<ToppingResponse>> createNewTopping(
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> topping,
  );

  @POST('/topping/{id}')
  Future<HttpResponse<ToppingResponse>> updateExistingTopping(
    @Path("id") String id,
    @Header("Authorization") token,
    @Body() Map<String, dynamic> topping,
  );

  @POST('/topping/{id}/{field}')
  Future<HttpResponse<ToppingResponse>> updateToppingFieldValue(
    @Path("id") String id,
    @Path("field") String field,
    @Header("Authorization") token,
    @Body() dynamic fieldValue,
  );

  @DELETE('/topping/{id}')
  Future<HttpResponse<ToppingResponse>> removeToppingByID(
    @Header("Authorization") token,
    @Path("id") String id,
  );

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

  @POST("/order/{id}/close")
  Future<HttpResponse<OrderResponse>> closeSuccessOrder(
    @Header('Authorization') String token,
    @Path("id") String id,
  );

  @DELETE("/order/{id}")
  Future<HttpResponse<OrderResponse>> cancelOrder(
    @Header('Authorization') String token,
    @Path("id") String id,
  );
}
