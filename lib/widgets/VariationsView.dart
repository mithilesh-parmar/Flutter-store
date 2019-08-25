import 'package:cool_store/states/detail_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Chooser.dart';

// TODO build it generic
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: state.product.attributes.map((value) {
              return Chooser(
                title: value.name,
                options: value.options,
              );
            }).toList());
  }
}


