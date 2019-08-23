import 'package:cool_store/states/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppState appState = Provider.of<AppState>(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: FlatButton(
              onPressed: () {
                appState.isDark
                    ? appState.setLightTheme()
                    : appState.setDarkTheme();
              },
              child: Text(
                'Change Theme',
              )),
        ),
      ),
    );
  }
}
