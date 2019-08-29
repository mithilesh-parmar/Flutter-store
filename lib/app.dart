import 'package:cool_store/screens/cart_screen.dart';
import 'package:cool_store/screens/home_screen.dart';
import 'package:cool_store/screens/category_screen.dart';
import 'package:cool_store/screens/setting_screen.dart';
import 'package:cool_store/states/app_state.dart';
import 'package:cool_store/states/cart_state.dart';
import 'package:cool_store/states/home_state.dart';
import 'package:cool_store/states/category_state.dart';
import 'package:cool_store/states/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => AppState(initialScreen: HomeScreen(), screens: [
            HomeScreen(),
            CategoryScreen(),
            CartScreen(),
            SettingScreen()
          ]),
        ),
        ChangeNotifierProvider(
          builder: (_) => HomeState(),
        ),
        ChangeNotifierProvider(
          builder: (_) => CartState(),
        ),
        ChangeNotifierProvider(
          builder: (_) => CategoryState(),
        ),
        ChangeNotifierProvider(
          builder: (_) => SettingState(),
        ),
      ],
      child: Consumer<AppState>(
        builder: (context, state, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: state.getTheme(),
          home: Scaffold(
            body: state.selectedScreen,
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (pos) => state.setScreenIndex(pos),
              currentIndex: state.selectedScreenIndex,
              selectedItemColor: state.getTheme().accentColor,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), title: Text('Home')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), title: Text('Search')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add_shopping_cart), title: Text('Cart')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), title: Text('Setting')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
