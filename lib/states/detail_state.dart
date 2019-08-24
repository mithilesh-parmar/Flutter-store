import 'package:cool_store/models/product.dart';
import 'package:cool_store/services/base_services.dart';
import 'package:flutter/foundation.dart';

class DetailState extends ChangeNotifier {
  bool isLoading, isRelatedProductsLoading;
  String _quantity;
  Services _services;
  ProductVariation _productVariation;

  Product _product;

  List<Product> relatedProducts;

  Product get product => _product;
  String _productId;
  int _categoryId;

  DetailState(id) {
    this._productId = id.toString();
    _quantity = '1';
    isLoading = true;
    isRelatedProductsLoading = true;
    relatedProducts = List();
    _services = Services();
    initProduct();
  }


  String get quantity => _quantity;

  initProduct() async {
    _product = await _services.getProduct(_productId);
    _categoryId = _product.categoryId;
    initRelatedProducts();
    isLoading = false;
    notifyListeners();
  }

  setQuantity(String value){
    _quantity = value;
    notifyListeners();
  }

  initRelatedProducts() async {
    relatedProducts = await _services.fetchProductsByCategory(
        categoryId: _categoryId, page: 1);
    isRelatedProductsLoading = false;
    notifyListeners();
  }

  void changeProductVariation(ProductVariation variation) {
    _productVariation = variation;
    notifyListeners();
  }
}
