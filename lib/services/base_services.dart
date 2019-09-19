import 'package:connectivity/connectivity.dart';
import 'package:cool_store/models/category.dart';
import 'package:cool_store/models/payment.dart';
import 'package:cool_store/models/product.dart';
import 'package:cool_store/models/user.dart';
import 'package:cool_store/services/woocommerce.dart';
import 'package:cool_store/states/cart_state.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseServices {
  Future<List<Category>> getCategories();

  Future<List<Product>> getProducts();

//
//  Future<List<Product>>  fetchProductsLayout({config, lang});
//
//  Future<List<Product>> fetchProductsByCategory(
//      {categoryId, page, minPrice, maxPrice, orderBy, lang, order});
//
//  Future<User> loginFacebook({String token});
//
//  Future<User> loginSMS({String token});
//
//  Future<List<Review>> getReviews(productId);
//
//  Future<List<ProductVariation>> getProductVariations(Product product);
//
//  Future<List<ShippingMethod>> getShippingMethods({Address address, String token});
//
//  Future<List<PaymentMethod>> getPaymentMethods({Address address, ShippingMethod shippingMethod, String token});
//
//  Future<Order> createOrder({CartModel cartModel, UserModel user});
//
//  Future<List<Order>> getMyOrders({UserModel userModel});
//
//  Future updateOrder(orderId, {status});
//
//  Future<List<Product>> searchProducts({name, page});
//
//  Future<User> getUserInfo(cookie);
//
//  Future<User> createUser({
//    firstName,
//    lastName,
//    username,
//    password,
//  });
//
//  Future<User> login({username, password});
//
//  Future<Product> getProduct(id);
//
//  Future<Coupons> getCoupons();

//
//  Future<List<dynamic>> getProducts();

  Future<List<dynamic>> fetchProductsByCategory(
      {categoryId, page, minPrice, maxPrice, orderBy, lang, order});

  Future<dynamic> loginFacebook({String token});

  Future<dynamic> loginSMS({String token});

  Future<List<dynamic>> getReviews(productId);

  Future<List<dynamic>> getProductVariations(dynamic product);

  Future<List<dynamic>> getShippingMethods({dynamic address, String token});

  Future<List<dynamic>> getPaymentMethods(
      {dynamic address, dynamic shippingMethod, String token});

  Future updateOrder(orderId, {status});

  Future<List<dynamic>> searchProducts({name, page});

  Future<dynamic> getUserInfo(cookie);

  Future<dynamic> createUser({
    firstName,
    lastName,
    username,
    password,
  });

  Future<dynamic> login({username, password});

  Future<dynamic> getProduct(id);

  Future<dynamic> getCoupons();

  Future createOrder(
      Map<String, int> productsInCart,
      Map<String, ProductVariation> productVariationsInCart,
      Address address,
      PaymentMethod paymentMethod,
      userId) {}
}

class Services implements BaseServices {
  BaseServices serviceApi = WooCommerce.fromConfig();

  static final Services _instance = Services._internal();

  factory Services() => _instance;

  Services._internal();

  @override
  Future createUser({firstName, lastName, username, password}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return serviceApi.createUser(
          firstName: firstName,
          lastName: lastName,
          username: username,
          password: password);
    } else {
      throw Exception("No internet connection");
    }
  }

  Future createOrder(
      Map<String, int> productsInCart,
      Map<String, ProductVariation> productVariationsInCart,
      Address address,
      PaymentMethod paymentMethod,
      [userId = 1]) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return serviceApi.createOrder(productsInCart, productVariationsInCart,
          address, paymentMethod, userId);
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<List<Product>> fetchProductsByCategory(
      {categoryId,
      page,
      minPrice,
      maxPrice,
      orderBy,
      lang = 'en',
      order}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return serviceApi.fetchProductsByCategory(
          categoryId: categoryId,
          page: page,
          minPrice: minPrice,
          maxPrice: maxPrice,
          order: order,
          orderBy: orderBy,
          lang: lang);
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<List<Category>> getCategories() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return serviceApi.getCategories();
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future getCoupons() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return serviceApi.getCoupons();
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<List> getPaymentMethods(
      {address, shippingMethod, String token}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return serviceApi.getPaymentMethods(
          address: address, shippingMethod: shippingMethod, token: token);
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<Product> getProduct(id) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return serviceApi.getProduct(id);
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<List<ProductVariation>> getProductVariations(product) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return serviceApi.getProductVariations(product);
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<List<Product>> getProducts() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return serviceApi.getProducts();
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<List<Review>> getReviews(productId) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return serviceApi.getReviews(productId);
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<List> getShippingMethods({address, String token}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return serviceApi.getShippingMethods(address: address, token: token);
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future getUserInfo(cookie) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return serviceApi.getUserInfo(cookie);
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future login({username, password}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return serviceApi.login(username: username, password: password);
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future loginFacebook({String token}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return serviceApi.loginFacebook(token: token);
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future loginSMS({String token}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return serviceApi.loginSMS(token: token);
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future<List<Product>> searchProducts({name, page}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return serviceApi.searchProducts(name: name, page: page);
    } else {
      throw Exception("No internet connection");
    }
  }

  @override
  Future updateOrder(orderId, {status}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return serviceApi.updateOrder(orderId, status: status);
    } else {
      throw Exception("No internet connection");
    }
  }

  void dispose() {
//    serviceApi.dispose();
  }
}
