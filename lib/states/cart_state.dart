import 'dart:collection';

import 'package:cool_store/models/product.dart';
import 'package:flutter/foundation.dart';

class CartState extends ChangeNotifier {
  // product and quantities
  Map<Product, String> _productsWithQuantity;

  // products list in cart
  List<Product> products;

  // quantities of products in cart
  List<String> quantities;

  //attributes of products in cart
  List<String> attributes;

  double totalCartAmount = 0;

  //TODO update according to shipping methods
  double totalCartExtraCharge = 200;
  double totalCartPayableAmount = 0;

  CartState() {
    _productsWithQuantity = HashMap();
    quantities = List();
    attributes = List();
    products = _productsWithQuantity.keys.toList(growable: true);
  }

  addProduct(
    Product product,
    String quantity,
    ProductVariation variation,
  ) {
    _productsWithQuantity.update(product, (_) => quantity,
        ifAbsent: () => quantity);
    String attributeSelected = '';
    variation.attributes.forEach((attribute) {
      attributeSelected += '${attribute.name}: ${attribute.option}\t';
    });
    attributes.add(attributeSelected);
    products.add(product);
    quantities.add(quantity);
    totalCartAmount += double.parse(variation.regularPrice);

    updateTotalPayableAmount();
    notifyListeners();
  }

  removeProduct(int index) {
    Product product = products[index];
    print('removing product at $index wichi is $product');
    products.removeAt(index);
    _productsWithQuantity.remove(product);
    attributes.removeAt(index);
    quantities.removeAt(index);
    notifyListeners();
    print('${products.length}');
  }

  addToWishList(int index) {
    removeProduct(index);
  }

  updateTotalPayableAmount() =>
      totalCartPayableAmount = totalCartAmount + totalCartExtraCharge;
}
