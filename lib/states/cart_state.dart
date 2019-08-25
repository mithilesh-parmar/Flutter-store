import 'dart:collection';

import 'package:cool_store/models/product.dart';
import 'package:flutter/foundation.dart';

class CartState extends ChangeNotifier {
  // product and quantities
  Map<Product, String> _productsWithQuantity;

  List<Product> products;
  List<String> quantities;
  List<String> attributes;

  CartState() {
    _productsWithQuantity = HashMap();
    quantities = List();
    attributes = List();
    products = _productsWithQuantity.keys.toList(growable: true);
  }

  // TODO add products from detail screen to cart screen
  addProduct(Product product, String quantity, ProductVariation variation,
      String variationsSelected) {
    _productsWithQuantity.update(product, (_) => quantity,
        ifAbsent: () => quantity);

    attributes.add(variationsSelected.replaceAll("[\\p{Ps}\\p{Pe}]", " "));
    products.add(product);
    quantities.add(quantity);
    notifyListeners();
  }
}
