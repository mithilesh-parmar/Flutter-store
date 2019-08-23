import 'package:cool_store/models/product.dart';
import 'package:cool_store/services/base_services.dart';
import 'package:flutter/foundation.dart';

class HomeState extends ChangeNotifier {
  Services _services;
  bool isLoading;
  List<Product> products;

  HomeState() {
    isLoading = true;
    _services = Services();
    products = List();
    getProducts();
  }

  getProducts() async {
    isLoading = true;
    notifyListeners();
    products = await _services.getProducts();
    isLoading = false;
    notifyListeners();
  }
}
