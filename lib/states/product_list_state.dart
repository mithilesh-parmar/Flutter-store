import 'package:cool_store/models/product.dart';
import 'package:cool_store/services/base_services.dart';
import 'package:flutter/foundation.dart';

class ProductListState extends ChangeNotifier {
  bool isLoading;
  Services _services;
  List<Product> _products;
  int _categoryId;

  List<Product> get products => _products;

  ProductListState(categoryID) {
    isLoading = true;
    this._categoryId = categoryID;
    _products = List();
    _services = Services();
    initProducts();
  }

  initProducts() async {
    _products = await _services.fetchProductsByCategory(
        categoryId: _categoryId, page: 1);
    isLoading = false;
    notifyListeners();
  }
}
