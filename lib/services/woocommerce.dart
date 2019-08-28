import 'package:cool_store/models/category.dart';
import 'package:cool_store/models/order.dart';
import 'package:cool_store/models/payment.dart';
import 'package:cool_store/models/product.dart';
import 'package:cool_store/models/user.dart';
import 'package:cool_store/services/base_services.dart';
import 'package:cool_store/services/woocommerce_api.dart';
import 'package:cool_store/states/cart_state.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:flutter/cupertino.dart';

class WooCommerce implements BaseServices {
  WooCommerceAPI wcApi;
  bool isSecure;
  String url;

  WooCommerce.fromConfig() {
    wcApi = WooCommerceAPI(
        url: Constants.URL_CLOUD,
        consumerKey: Constants.CONSUMER_KEY_CLOUD,
        consumerSecret: Constants.CONSUMER_SECRET_CLOUD);
    isSecure = true;
  }

  @override
  Future createUser({firstName, lastName, username, password}) {
    // TODO: implement createUser
    return null;
  }

  @override
  Future<List<Product>> fetchProductsByCategory(
      {categoryId, page, minPrice, maxPrice, orderBy, lang, order}) async {
    try {
      List<Product> list = [];

      var endPoint = "products?lang=$lang&per_page=10&page=$page";
      if (categoryId > -1) {
        endPoint += "&category=$categoryId";
      }
      if (minPrice != null) {
        endPoint += "&min_price=${(minPrice as double).toInt().toString()}";
      }
      if (maxPrice != null && maxPrice > 0) {
        endPoint += "&max_price=${(maxPrice as double).toInt().toString()}";
      }
      if (orderBy != null) {
        endPoint += "&orderby=$orderBy";
      }
      if (order != null) {
        endPoint += "&order=$order";
      }
      var response = await wcApi.getAsync(endPoint);

      for (var item in response) {
        list.add(Product.fromJson(item));
      }
      return list;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<Category>> getCategories() async {
    try {
      var response =
          await wcApi.getAsync("products/categories?&exclude=311&per_page=10");
      List<Category> list = [];

      for (var item in response) {
        list.add(Category.fromJson(item));
      }
      return list;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future getCoupons() async {
    try {
      var response = await wcApi.getAsync("coupons");
      print(response.toString());
      return null;
//      return Coupons.getListCoupons(response);
    } catch (e) {
      throw e;
    }
  }

  Future createOrder(
      Map<String, int> productsInCart,
      Map<String, ProductVariation> productVariationsInCart,
      Address address,
      PaymentMethod paymentMethod,
      userId) async {
    try {
      var params = Order().toJson(productsInCart, productVariationsInCart,
          address, paymentMethod, userId);
      var response = await wcApi.postAsync('orders', params);
      print('$response');
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List> getPaymentMethods(
      {address, shippingMethod, String token}) async {
    try {
      var response = await wcApi.getAsync("payment_gateways");
      List<dynamic> list = [];
      debugPrint('$response');
//      for (var item in response) {
//        list.add(PaymentMethod.fromJson(item));
//      }
      return list;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Product> getProduct(id) async {
    try {
      var response = await wcApi.getAsync("products/$id");
      return Product.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<ProductVariation>> getProductVariations(product) async {
    try {
      var response =
          await wcApi.getAsync("products/${product.id}/variations?per_page=20");
      List<ProductVariation> list = [];
      for (var item in response) {
        list.add(ProductVariation.fromJson(item));
      }
      return list;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<Product>> getProducts() async {
    try {
      var response = await wcApi.getAsync("products");
      List<Product> list = [];
      for (var item in response) {
        list.add(Product.fromJson(item));
      }
      return list;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List> getReviews(productId) async {
    try {
      var response = await wcApi.getAsync("products/$productId/reviews");
      List<dynamic> list = [];
      debugPrint('$list');
//      for (var item in response) {
//        list.add(Review.fromJson(item));
//      }
      return list;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List> getShippingMethods({address, String token}) async {
    try {
      var response = await wcApi.getAsync("shipping_methods");
      List<dynamic> list = [];
      debugPrint('$response');
//      for (var item in response) {
//        list.add(ShippingMethod.fromJson(item));
//      }
      return list;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<Product>> searchProducts({name, page}) async {
    try {
      var response =
          await wcApi.getAsync("products?search=$name&page=$page&per_page=5");
      List<Product> list = [];
      debugPrint('$response');
      for (var item in response) {
        list.add(Product.fromJson(item));
      }
      return list;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future updateOrder(orderId, {status}) async {
    try {
      var response =
          await wcApi.putAsync("orders/$orderId", {"status": status});
      if (response["message"] != null) {
        throw Exception(response["message"]);
      } else {
        print(response);
        return null;
//        return Order.fromJson(response);
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future getUserInfo(cookie) {
    // TODO: implement getUserInfo
    return null;
  }

  @override
  Future login({username, password}) {
    // TODO: implement login
    return null;
  }

  @override
  Future loginFacebook({String token}) {
    // TODO: implement loginFacebook
    return null;
  }

  @override
  Future loginSMS({String token}) {
    // TODO: implement loginSMS
    return null;
  }

  void dispose() {
    wcApi.dispose();
  }

  /// Get Nonce for Any Action
//  Future getNonce({method = 'register'}) async {
//    try {
//      http.Response response =
//      await http.get("$url/api/get_nonce/?controller=mstore_user&method=$method&$isSecure");
//      if (response.statusCode == 200) {
//        return convert.jsonDecode(response.body)['nonce'];
//      } else {
//        throw Exception(['error getNonce', response.statusCode]);
//      }
//    } catch (e) {
//      throw e;
//    }
//  }
}
