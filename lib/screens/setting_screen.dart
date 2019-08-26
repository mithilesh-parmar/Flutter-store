import 'package:cool_store/states/app_state.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppState appState = Provider.of<AppState>(context);
    return SafeArea(
        child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: Constants.screenAwareSize(80, context),
          flexibleSpace: FlexibleSpaceBar(
            background: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    'Setting',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway',
                        fontSize: 40),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 17, vertical: 8),
                ),
              ],
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          ListTile(
            onTap: () {
              appState.isDark
                  ? appState.setLightTheme()
                  : appState.setDarkTheme();
            },
            leading: Icon(Icons.lightbulb_outline),
            title: Text('Change Theme'),
          )
        ]))
      ],
    ));
  }
}
