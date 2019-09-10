import 'dart:collection';
import 'dart:convert';
import 'package:cool_store/models/payment.dart';
import 'package:cool_store/models/product.dart';
import 'package:cool_store/models/user.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';

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

  Map<int, Product> get products => _products; //  addProduct(

  Map<Product, ProductVariation> _wishListProducts = HashMap();

  Map<Product, ProductVariation> get wishListProducts => _wishListProducts;

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
    _loadFromLocalStorage();
  }

  addProductToCart(Product product, ProductVariation variation, int quantity) {
    _productsInCart.update(product.id.toString(), (_) => quantity,
        ifAbsent: () => quantity);
    _products.update(product.id, (_) => product, ifAbsent: () => product);
    _productVariationsInCart.update(product.id.toString(), (_) => variation,
        ifAbsent: () => variation);
    notifyListeners();
//    _saveProductsToLocalStorage();
    print('_productsInCart: ${json.encode(_productsInCart)}');
    print('_products: ${json.encode(_products)}');
    print('_productVariationsInCart: ${json.encode(_productVariationsInCart)}');
  }

  _saveProductsToLocalStorage() async {
    final LocalStorage _localStorage = LocalStorage(
      Constants.APP_FOLDER,
    );

    try {
      final ready = await _localStorage.ready;
      if (ready) {
        await _localStorage.setItem(Constants.kLocalKey['productsInCart'],
            json.encode(_productsInCart));
        await _localStorage.setItem(
            Constants.kLocalKey['cartproducts'], json.encode(_products));
        await _localStorage.setItem(
            Constants.kLocalKey['productVariationsInCart'],
            json.encode(_productVariationsInCart));
      }
    } catch (e) {
      throw e;
    }
  }

  _loadFromLocalStorage() async {
    final LocalStorage _localStorage = LocalStorage(Constants.APP_FOLDER);
    try {
      final ready = await _localStorage.ready;
      if (ready) {
        if (_localStorage.getItem(Constants.kLocalKey['productsInCart']) !=
            null)
          _productsInCart = json.decode(await _localStorage
              .getItem(Constants.kLocalKey['productsInCart']));
        if (_localStorage.getItem(Constants.kLocalKey['cartproducts']) != null)
          _products = json.decode(
              await _localStorage.getItem(Constants.kLocalKey['cartproducts']));
        if (_localStorage
                .getItem(Constants.kLocalKey['productVariationsInCart']) !=
            null)
          _productVariationsInCart = json.decode(await _localStorage
              .getItem(Constants.kLocalKey['productVariationsInCart']));
        print('cart prodcuts Loaded from localstorage');
      }
    } catch (e) {
      throw e;
    }
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

    _saveProductsToLocalStorage();
  }

  setCouponCode(String value) {
    couponCode = value;
  }

  updateTotalPayableAmount() =>
      totalCartPayableAmount = totalCartAmount + totalCartExtraCharge;
}
