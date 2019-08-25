import 'package:cool_store/states/detail_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Chooser.dart';


class VariationsView extends StatefulWidget {
  @override
  _VariationsViewState createState() => _VariationsViewState();
}

class _VariationsViewState extends State<VariationsView> {
  @override
  Widget build(BuildContext context) {
    final DetailState state = Provider.of<DetailState>(context);
    return state.isVariantsLoading
        ? Container()
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: state.product.attributes.map((value) {
              return Chooser(
                title: value.name,
                options: value.options,
              );
            }).toList());
  }
}


