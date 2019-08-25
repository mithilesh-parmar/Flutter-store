import 'package:cool_store/states/detail_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuantityChooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DetailState>(builder: (context, state, child) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Center(
          child: DropdownButton(
            value: state.quantity.toString(),
            items: [
              DropdownMenuItem(
                child: Center(child: Text('1')),
                value: '1',
              ),
              DropdownMenuItem(
                child: Center(child: Text('2')),
                value: '2',
              ),
              DropdownMenuItem(
                child: Center(child: Text('3')),
                value: '3',
              ),
            ],
            onChanged: (value) {
              state.setQuantity(value);
            },
          ),
        ),
      );
    });
  }
}
