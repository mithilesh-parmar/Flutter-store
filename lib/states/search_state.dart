import 'package:cool_store/models/product.dart';
import 'package:cool_store/services/base_services.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchState extends ChangeNotifier {
  bool isResultLoading = true;
  bool showKeywords = true;

  String searchKeyword;
  List<String> keyWords = List();
  List<Product> searchResult = List();
  int currentPage = 1;
  Services _services = Services();

  SearchState() {
    _getRecentSearchList();
  }

  setKeyword(String value) {
    isResultLoading = true;
    showKeywords = false;
    notifyListeners();
    searchKeyword = value;
    if (!keyWords.contains(value)) keyWords.add(value);
    _performSearch();
  }

  _performSearch() async {
    searchResult =
        await _services.searchProducts(name: searchKeyword, page: currentPage);
    isResultLoading = false;
    notifyListeners();
  }

  addKeywordsToStorage() async {
    try {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      await _pref.setStringList(
          Constants.kLocalKey['recentSearches'], keyWords);
    } catch (e) {
      print(e);
    }
  }

  clearResult() {
    showKeywords = true;
    searchResult.clear();
    notifyListeners();
  }

  _getRecentSearchList() async {
    try {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      final list = _pref.getStringList(Constants.kLocalKey['recentSearches']);
      if (list != null && list.length > 0) keyWords = list;
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  removeKeyword(String value) {
    keyWords.remove(value);
    notifyListeners();
  }
}
