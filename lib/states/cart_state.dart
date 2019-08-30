import 'dart:collection';

import 'package:cool_store/models/payment.dart';
import 'package:cool_store/models/product.dart';
import 'package:cool_store/models/user.dart';
import 'package:flutter/foundation.dart';

class CartState extends ChangeNotifier {
  // product and id
  Map<int, Product> _products;

  // product id and the quantity
  Map<String, int> _productsInCart;

  Map<String, int> get productsInCart =>
      _productsInCart; // products list in cart

  //product id and variations
  Map<String, ProductVariation> _productVariationsInCart;

  Map<String, ProductVariation> get productVariationsInCart =>
      _productVariationsInCart;

  double totalCartAmount = 0;

  // product id and quantity selected
  Map<String, int> _productQuantityInCart;

  Map<String, int> get productQuantityInCart => _productQuantityInCart;

  //TODO update according to shipping methods
  double totalCartExtraCharge = 200;
  double totalCartPayableAmount = 0;

  Address address;
  PaymentMethod paymentMethod;

  String couponCode;

  CartState() {
    _products = HashMap();
    _productsInCart = HashMap();
    _productVariationsInCart = HashMap();
    _productQuantityInCart = HashMap();
    address = Address(
        zipCode: '343905',
        firstName: 'mithilesh',
        lastName: 'parmar',
        email: 'test@cool.com',
        street: 'vit road',
        city: 'jaipur',
        state: 'Rajasthan',
        country: 'in',
        phoneNumber: '19863921631');
    paymentMethod = PaymentMethod(
        id: '1', title: 'cod', description: 'cash on delivery', enabled: true);
  }

  Map<int, Product> get products => _products; //  addProduct(

  Map<Product, ProductVariation> _wishListProducts = HashMap();

  Map<Product, ProductVariation> get wishListProducts => _wishListProducts;

  addProductToCart(Product product, ProductVariation variation, int quantity) {
    _productsInCart.update(product.id.toString(), (_) => quantity,
        ifAbsent: () => quantity);
    _products.update(product.id, (_) => product, ifAbsent: () => product);
    _productVariationsInCart.update(product.id.toString(), (_) => variation,
        ifAbsent: () => variation);
    notifyListeners();
  }

  addProductToWishList(Product product, ProductVariation variation) {
    _wishListProducts.update(product, (_) => variation,
        ifAbsent: () => variation);
    removeProduct(product.id);
    notifyListeners();
  }

  removeProductAndAddToCart(
      Product product, ProductVariation productVariation) {
    _wishListProducts.remove(product);
    notifyListeners();
    addProductToCart(product, productVariation, 1);

  }

  removeProduct(int id) {
    _productsInCart.remove(id.toString());
    _products.remove(id);
    _productVariationsInCart.remove(id);

    notifyListeners();
    print('${products.length}');
  }

  setCouponCode(String value) {
    couponCode = value;
  }

  updateTotalPayableAmount() =>
      totalCartPayableAmount = totalCartAmount + totalCartExtraCharge;
}
