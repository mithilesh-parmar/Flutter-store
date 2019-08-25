import 'package:cool_store/models/product.dart';
import 'package:cool_store/states/detail_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Chooser.dart';

class VariationsView extends StatelessWidget {
  Product product;

  VariationsView(this.product);

  @override
  Widget build(BuildContext context) {
    final DetailState state = Provider.of<DetailState>(context);
    return
//      state.isLoading
//        ? Container()
//        :
    Column(

            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: product.attributes.map((value) {
              return Chooser(
                title: value.name,
                options: value.options,
              );
            }).toList());
  }
}
