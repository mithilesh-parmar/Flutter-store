import 'package:cool_store/models/product.dart';
import 'package:cool_store/states/detail_state.dart';
import 'package:cool_store/widgets/VariantChooser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Chooser.dart';

class VariationsView extends StatelessWidget {
  final Product product;

  VariationsView(this.product);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: product.attributes.map((value) {
          if (value.name == 'SIZE')
            return VariantChooser(
              title: value.name,
              options: value.options,
            );
          else if (value.name == 'COLOR')
            return VariantChooser(
              title: value.name,
              options: value.options,
            );
          return Chooser(
            title: value.name,
            options: value.options,
          );
        }).toList());
  }
}
