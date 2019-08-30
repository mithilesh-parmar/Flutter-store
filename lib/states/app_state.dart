import 'package:cool_store/utils/constants.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  ThemeData _themeData = Constants.lightTheme;
  bool isDark = false;
  int _selectedScreenIndex = 0;
  Widget _selectedScreen;
  List _screens;

  AppState({@required initialScreen, @required screens}) {
    _selectedScreen = initialScreen;
    _screens = screens;
    _reteriveThemePreference();
  }

  Widget get selectedScreen => _selectedScreen;

  List get screens => _screens;

  ThemeData getTheme() => _themeData;

  _setTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
    _saveThemePreference();
  }

  int get selectedScreenIndex => _selectedScreenIndex;

  setScreenIndex(int pos) {
    _selectedScreenIndex = pos;
    _selectedScreen = _screens[pos];
    notifyListeners();
  }

  changeScreenTo(Widget widget) {
    _selectedScreenIndex = _screens.indexOf(widget);
    _selectedScreen = _screens[_selectedScreenIndex];
    notifyListeners();
  }

  setDarkTheme() {
    isDark = true;
    _setTheme(Constants.darkTheme);
  }

  setLightTheme() {
    isDark = false;
    _setTheme(Constants.lightTheme);
  }

  _saveThemePreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(Constants.kLocalKey['isDarkTheme'], isDark);
  }

  _reteriveThemePreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey(Constants.kLocalKey['isDarkTheme'])) {
      isDark = preferences.getBool(Constants.kLocalKey['isDarkTheme']);
      isDark ? setDarkTheme() : setLightTheme();
    }
  }

  void navigateToHome() {
    setScreenIndex(0);
  }
}
