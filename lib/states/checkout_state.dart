import 'package:cool_store/models/payment.dart';
import 'package:cool_store/models/product.dart';
import 'package:cool_store/models/shipping_methods.dart';

import 'package:cool_store/models/user.dart';
import 'package:cool_store/services/base_services.dart';

import 'package:flutter/foundation.dart';

class CheckoutState extends ChangeNotifier {
  bool isLoading = true;
  String response = '';
  Services _service = Services();
  List _shippingMethods = List();
  bool isShippingMethodsLoading = true;
  ShippingMethods selectedShippingMethod;

  Services get service => _service;

  CheckoutState() {
    getShippingMethods();
  }

  createOrder(
      Map<String, int> productsInCart,
      Map<String, ProductVariation> productVariationsInCart,
      Address address,
      PaymentMethod paymentMethod) {
    _service.createOrder(
        productsInCart, productVariationsInCart, address, paymentMethod);
  }

  getShippingMethods() async {
    _shippingMethods = await _service.getShippingMethods();
    isShippingMethodsLoading = false;
    notifyListeners();
  }

  List get shippingMethods => _shippingMethods;

  setShippingMethod(item){
    selectedShippingMethod = item;
    notifyListeners();
  }

}
