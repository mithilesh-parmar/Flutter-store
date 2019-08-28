import 'dart:collection';

import 'package:cool_store/models/product.dart';
import 'package:flutter/foundation.dart';

class CartState extends ChangeNotifier {
  // product and id
  Map<int, Product> _products;

  // product id and the quantity
  Map<String, int> _productsInCart;

  Map<String, int> get productsInCart =>
      _productsInCart; // products list in cart
//  List<Product> products;

  // quantities of products in cart
//  List<String> quantities;

  //attributes of products in cart
//  List<String> attributes;

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

  CartState() {
    _products = HashMap();
    _productsInCart = HashMap();
    _productVariationsInCart = HashMap();
    _productQuantityInCart = HashMap();
//    quantities = List();
//    attributes = List();
  }

  Map<int, Product> get products => _products; //  addProduct(
//    Product product,
//    String quantity,
//    ProductVariation variation,
//  ) {
//    _productsWithQuantity.update(product, (_) => quantity,
//        ifAbsent: () => quantity);
//    String attributeSelected = '';
//    variation.attributes.forEach((attribute) {
//      attributeSelected += '${attribute.name}: ${attribute.option}\t';
//    });
//
//    attributes.add(attributeSelected);
//    products.add(product);
//    quantities.add(quantity);
//    totalCartAmount += double.parse(variation.regularPrice);
//
//    updateTotalPayableAmount();
//    notifyListeners();
//  }

  addProductToCart(Product product, ProductVariation variation, int quantity) {
    _productsInCart.update(product.id.toString(), (_) => quantity,
        ifAbsent: () => quantity);
    _products.update(product.id, (_) => product, ifAbsent: () => product);
    _productVariationsInCart.update(product.id.toString(), (_) => variation,
        ifAbsent: () => variation);
    notifyListeners();
  }

  removeProduct(int index) {
    Product product = products[index];
    print('removing product at $index wichi is $product');
//    products.removeAt(index);
//    _productsWithQuantity.remove(product);
//    attributes.removeAt(index);
//    quantities.removeAt(index);
    notifyListeners();
    print('${products.length}');
  }

  addToWishList(int index) {
    removeProduct(index);
  }

  updateTotalPayableAmount() =>
      totalCartPayableAmount = totalCartAmount + totalCartExtraCharge;
}
