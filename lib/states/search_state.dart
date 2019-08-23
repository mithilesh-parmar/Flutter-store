import 'package:cool_store/models/category.dart' as Product;
import 'package:cool_store/services/base_services.dart';
import 'package:flutter/foundation.dart';
import 'package:cool_store/models/product.dart' as Woocommerce;

class SearchState extends ChangeNotifier {
  Services _services;
  bool isLoading;
  bool isSearchResultLoading;
  Map<int, Product.Category> _categoryList;
  String errorMessage;
  List<Product.Category> categories;
  List<Woocommerce.Product> _searchResult;

  SearchState() {
    isLoading = true;
    isSearchResultLoading = true;
    categories = List();
    _categoryList = {};
    _services = Services();
    initCategories();
  }


  List<Woocommerce.Product> get searchResult => _searchResult;

  performSearch(String query) async {
    _searchResult = List();
    _searchResult = await _services.searchProducts(name: query,page: 1);
    isSearchResultLoading = false;
    notifyListeners();
  }

  initCategories() async {
    try {
      categories = await _services.getCategories();
      isLoading = false;
      for (var cat in categories) {
        _categoryList[cat.id] = cat;
      }
      notifyListeners();
    } catch (err) {
      isLoading = false;
      errorMessage = err.toString();
      notifyListeners();
    }
  }
}
