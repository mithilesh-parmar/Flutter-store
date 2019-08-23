import 'package:cool_store/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  ThemeData _themeData = Constants.lightTheme;
  bool isDark = false;
  int _selectedScreenIndex = 0;
  Widget _selectedScreen;
  List _screens;

  AppState({@required initialScreen, @required screens}) {
    _selectedScreen = initialScreen;
    _screens = screens;
  }

  Widget get selectedScreen => _selectedScreen;

  ThemeData getTheme() => _themeData;

  _setTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
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
}
