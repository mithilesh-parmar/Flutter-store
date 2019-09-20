import 'dart:collection';

import 'package:cool_store/models/product.dart';
import 'package:cool_store/services/base_services.dart';
import 'package:cool_store/states/cart_state.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

enum Errors { variationNotSelected, productNotLoaded }

class DetailState extends ChangeNotifier {
  bool isLoading,
      isRelatedProductsLoading,
      isVariantsLoading,
      isReviewsLoading,
      doesContainReviews;
  String _quantity;
  Services _services;
  ProductVariation _currentVariation;
  Product _product;
  List<Product> relatedProducts;
  List<ProductVariation> _productVariations;
  List<Review> _reviews;

  String _productId;
  int _categoryId;

  // contains id of variation and variation itself
  Map<String, ProductVariation> variationMap = HashMap();

  // container attribute name and value
  Map<String, String> attributesMap = HashMap();

  DetailState(id) {
    this._productId = id.toString();
    _quantity = '1';
    isLoading = true;
    isVariantsLoading = true;
    isRelatedProductsLoading = true;
    isReviewsLoading = true;
    doesContainReviews = false;
    relatedProducts = List();
    _productVariations = List();
    _reviews = List();
    _services = Services();
    initProduct();
  }

  String get quantity => _quantity;

  Product get product => _product;

  initProduct() async {
    try {
      _product = await _services.getProduct(_productId);
      _categoryId = _product.categoryId;
      isLoading = false;
      notifyListeners();
      initRelatedProducts();
      initProductVariations();
      initReviews();
    } catch (e) {
      print('$e');
//      throw Exception('No INTERNET CONNECTION');
    }
  }

  changeAttributesTo(String attribute, String value) {
    if (value == null) print('no value for $attribute selected');
    attributesMap.update(attribute, (_) => value, ifAbsent: () => value);
    changeProductVariation(variationMap[attributesMap.toString()]);
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

  initReviews() async {
    _reviews = await _services.getReviews(_product.id);
    if (_reviews.length > 0) doesContainReviews = true;
    isReviewsLoading = false;
    notifyListeners();
  }

  List<Review> getTopReviews() {
    List<Review> topReviews =
        _reviews.length > 5 ? _reviews.sublist(0, 5) : _reviews;
    return topReviews;
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
      variationMap.update(map.toString(), (_) => variant,
          ifAbsent: () => variant);
    });
  }

  List<ProductVariation> get productVariations => _productVariations;

  setQuantity(String value) {
    _quantity = value;
    notifyListeners();
  }

  addToCart(context) {
    if (_currentVariation == null) throw 'Please select variation';
    if (_product == null) throw 'product not loaded';
    Provider.of<CartState>(context)
        .addProductToCart(_product, _currentVariation, int.parse(quantity));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _services.dispose();
  }
}
