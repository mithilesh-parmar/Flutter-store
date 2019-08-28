import 'dart:developer';

import 'package:cool_store/models/payment.dart';
import 'package:cool_store/models/product.dart';
import 'package:cool_store/models/user.dart';
import 'package:cool_store/services/base_services.dart';
import 'package:cool_store/states/cart_state.dart';
import 'package:flutter/foundation.dart';

class CheckoutState extends ChangeNotifier {
  bool isLoading = true;
  String response = '';
  Services _service = Services();

   createOrder(
      Map<String, int> productsInCart,
      Map<String, ProductVariation> productVariationsInCart,
      Address address,
      PaymentMethod paymentMethod) {
    _service.createOrder(
        productsInCart, productVariationsInCart, address, paymentMethod);
  }
}
