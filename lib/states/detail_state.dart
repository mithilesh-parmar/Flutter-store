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

  Product get product => _product;
  String _productId;
  int _categoryId;

  Map<String, ProductVariation> variations;
  Map<String, String> attributes;

  List<String> attributesNames;

  Map<String, String> selectedAttributes = HashMap();

  DetailState(id) {
    this._productId = id.toString();
    _quantity = '1';
    isLoading = true;
    isVariantsLoading = true;
    isRelatedProductsLoading = true;
    variations = HashMap();
    attributesNames = List();
    attributes = HashMap();
    relatedProducts = List();
    _productVariations = List();
    _services = Services();
    initProduct();
  }

  String get quantity => _quantity;

  initProduct() async {
    _product = await _services.getProduct(_productId);
    _product.attributes.forEach((value) {
      attributesNames.add(value.name);
    });
    _categoryId = _product.categoryId;
    isLoading = false;
    notifyListeners();
    initRelatedProducts();
    initProductVariations();
  }

  changeAttributesTo(String attribute, String value) {
    selectedAttributes.update(attribute, (_) => value, ifAbsent: () => value);
    print('$attribute: $value');
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

    _productVariations.forEach((variant) {
      String currentAttributes = '';
      variations.update(variant.id.toString(), (_) => variant,
          ifAbsent: () => variant);
      variant.attributes.forEach((attribute) {
        currentAttributes += '${attribute.option}';
      });
      if (variant.attributes.length == 0) currentAttributes = 'UNIVERSAL';
      attributes.update(currentAttributes, (_) => variant.id.toString(),
          ifAbsent: () => variant.id.toString());
    });
    isVariantsLoading = false;
    notifyListeners();
  }

  List<ProductVariation> get productVariations => _productVariations;

  setQuantity(String value) {
    _quantity = value;
    notifyListeners();
  }

  addToCart() {
    print('${selectedAttributes}');

    String attribute =
        attributes[selectedAttributes['COLOR'] + selectedAttributes["SIZE"]];
    print('$attribute');
    print('${variations[attribute].price}');
  }

  void changeProductVariation(ProductVariation variation) {
    _currentVariation = variation;
    notifyListeners();
  }
}
