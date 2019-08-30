import 'package:cool_store/models/product.dart';
import 'package:cool_store/services/base_services.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';

class HomeState extends ChangeNotifier {
  Services _services;
  bool isLoading;
  List<Product> products;
  String errorMessage;
  bool errorOccured = false;

  HomeState() {
    isLoading = true;
    _services = Services();
    products = List();
    getProducts();
  }

  getProducts() async {
    try {
      products = await _services.getProducts();
      isLoading = false;
      notifyListeners();
      cacheProducts();
    } catch (e) {
      errorOccured = true;
      errorMessage = e.toString();
      loadProductsFromCache();
    }
  }

  // cached products to local storage
  cacheProducts() async {
    final LocalStorage _localStorage = LocalStorage(
      Constants.APP_FOLDER,
    );

    try {
      final ready = await _localStorage.ready;
      if (ready) {
        await _localStorage.setItem(Constants.kLocalKey["home"], products);
      }
    } catch (e) {
      throw e;
    }
  }

  // called if there is a connection problem to load last cached products from local storage
  loadProductsFromCache() async {
    isLoading = true;
    final LocalStorage storage = new LocalStorage(Constants.APP_FOLDER);
    try {
      final ready = await storage.ready;
      if (ready) {
        final json = storage.getItem(Constants.kLocalKey["home"]);
        if (json != null) {
          List<Product> list = [];
          for (var item in json) {
            list.add(Product.fromLocalJson(item));
          }
          products = list;
        }
      }
    } catch (err) {
      print(err);
    }
    isLoading = false;
    notifyListeners();
  }
}
