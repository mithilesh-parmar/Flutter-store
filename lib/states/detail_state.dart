import 'package:cool_store/models/product.dart';
import 'package:cool_store/services/base_services.dart';
import 'package:flutter/foundation.dart';

class DetailState extends ChangeNotifier {
  bool isLoading;
  Services _services;
  ProductVariation _productVariation;

  Product _product;

  Product get product => _product;
  String _productId;

  DetailState(id) {
    this._productId = id.toString();
    isLoading = true;

    _services = Services();
    initProduct();
  }

  initProduct() async {
    _product = await _services.getProduct(_productId);
    isLoading = false;
    notifyListeners();
  }

  void changeProductVariation(ProductVariation variation) {
    _productVariation = variation;
    notifyListeners();
  }
}
