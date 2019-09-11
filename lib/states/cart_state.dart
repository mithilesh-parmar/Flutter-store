import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'package:cool_store/models/payment.dart';
import 'package:cool_store/models/product.dart';
import 'package:cool_store/models/user.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';

class CartState extends ChangeNotifier {
  // product and id
  Map<String, Product> _products;

  // product id and the quantity
  Map<String, int> _productsInCart;

  Map<String, int> get productsInCart =>
      _productsInCart; // products list in cart

  //product id and variations
  Map<String, ProductVariation> _productVariationsInCart;

  Map<String, ProductVariation> get productVariationsInCart =>
      _productVariationsInCart;

  double totalCartAmount = 0;

  Map<String, Product> get products => _products; //  addProduct(

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

  List localSavedProducts = List();

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
    localSavedProducts.add(LocalSavedProduct(
        productVariation: variation, product: product, quantity: quantity));
    _productsInCart.update(product.id.toString(), (_) => quantity,
        ifAbsent: () => quantity);
    _products.update(product.id.toString(), (_) => product,
        ifAbsent: () => product);
    _productVariationsInCart.update(product.id.toString(), (_) => variation,
        ifAbsent: () => variation);
    notifyListeners();
    _saveProductsToLocalStorage();
  }

  // Save products to local storage
  _saveProductsToLocalStorage() async {
    final LocalStorage _localStorage = LocalStorage(
      Constants.APP_FOLDER,
    );

    try {
      final ready = await _localStorage.ready;
      if (ready) {
        await _localStorage.setItem(Constants.kLocalKey['productsInCart'],
            json.encode(localSavedProducts));
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
        if (await _localStorage
                .getItem(Constants.kLocalKey['productsInCart']) !=
            null) {
          localSavedProducts = jsonDecode(await _localStorage
              .getItem(Constants.kLocalKey['productsInCart']));
          localSavedProducts.forEach((localJson) {
            print('$localJson');
            final item = LocalSavedProduct.fromJson(localJson);
            print('$item');
            _productsInCart.update(
                item.product.id.toString(), (_) => item.quantity,
                ifAbsent: () => item.quantity);
            _products.update(item.product.id.toString(), (_) => item.product,
                ifAbsent: () => item.product);
            _productVariationsInCart.update(
                item.product.id.toString(), (_) => item.productVariation,
                ifAbsent: () => item.productVariation);
            notifyListeners();
          });
        }
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

// class used to save and reterive product from local storage
class LocalSavedProduct {
  Product product;
  ProductVariation productVariation;
  int quantity;

  LocalSavedProduct({this.product, this.productVariation, this.quantity});

  Map<String, dynamic> toJson() {
    return {
      'product': product,
      'productVariation': productVariation,
      'quantity': quantity
    };
  }

  LocalSavedProduct.fromJson(Map<String, dynamic> parsedJson) {
    product = Product.fromLocalJson(parsedJson['product']);
    productVariation =
        ProductVariation.fromJson(parsedJson['productVariation']);
    quantity = parsedJson['quantity'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return '\n$product\n$productVariation\n$quantity';
  }
}
