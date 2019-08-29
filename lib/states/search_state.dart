import 'package:cool_store/models/product.dart';
import 'package:cool_store/services/base_services.dart';
import 'package:flutter/foundation.dart';

class SearchState extends ChangeNotifier {
  bool isResultLoading = true;
  bool showKeywords = true;

  String searchKeyword;
  List<String> keyWords = List();
  List<Product> searchResult = List();
  int currentPage = 1;
  Services _services = Services();

  setKeyword(String value) {
    isResultLoading = true;
    showKeywords = false;
    searchKeyword = value;
    keyWords.add(value);
    performSearch();
  }

  performSearch() async {
    searchResult =
        await _services.searchProducts(name: searchKeyword, page: currentPage);
    isResultLoading = false;
    notifyListeners();
  }

  addKeywordToStorage() {
    //TODO add keyword to localstorage
  }

  clearResult() {
    showKeywords = true;
    searchResult.clear();
    notifyListeners();
  }
}
