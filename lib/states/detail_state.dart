import 'dart:collection';

import 'package:cool_store/models/product.dart';
import 'package:cool_store/services/base_services.dart';
import 'package:flutter/foundation.dart';

class DetailState extends ChangeNotifier {
  bool isLoading, isRelatedProductsLoading, isVariantsLoading;
  String _quantity;
  Services _services;
  ProductVariation _currentVariation;
  Product _product;
  List<Product> relatedProducts;
  List<ProductVariation> _productVariations;
  String _productId;
  int _categoryId;

  Map<String, ProductVariation> testMap = HashMap();
  Map<String, String> testAttributesMap = HashMap();

  DetailState(id) {
    this._productId = id.toString();
    _quantity = '1';
    isLoading = true;
    isVariantsLoading = true;
    isRelatedProductsLoading = true;
    relatedProducts = List();
    _productVariations = List();
    _services = Services();
    initProduct();
  }

  String get quantity => _quantity;

  Product get product => _product;

  initProduct() async {
    _product = await _services.getProduct(_productId);
    _categoryId = _product.categoryId;
    isLoading = false;
    notifyListeners();
    initRelatedProducts();
    initProductVariations();
  }

  changeAttributesTo(String attribute, String value) {
    testAttributesMap.update(attribute, (_) => value, ifAbsent: () => value);
    changeProductVariation(testMap[testAttributesMap.toString()]);
  }

  void changeProductVariation(ProductVariation variation) {
    _currentVariation = variation;
    notifyListeners();
  }

  ProductVariation get currentVariation => _currentVariation;

  initRelatedProducts() async {
    relatedProducts = await _services.fetchProductsByCategory(
        categoryId: _categoryId, page: 1);
    isRelatedProductsLoading = false;
    notifyListeners();
  }

  initProductVariations() async {
    _productVariations = await _services.getProductVariations(_product);

    isVariantsLoading = false;
    notifyListeners();

    _productVariations.forEach((variant) {
      Map<String, String> map = HashMap();
      variant.attributes.forEach((value) {
        map.update(value.name, (_) => value.option,
            ifAbsent: () => value.option);
      });
      testMap.update(map.toString(), (_) => variant, ifAbsent: () => variant);
    });
  }

  List<ProductVariation> get productVariations => _productVariations;

  setQuantity(String value) {
    _quantity = value;
    notifyListeners();
  }

  addToCart() {
    print('$_currentVariation quantity: $_quantity');
  }
}
