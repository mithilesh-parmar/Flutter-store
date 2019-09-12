import 'package:cool_store/states/cart_state.dart';
import 'package:cool_store/states/checkout_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CartState>(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Order placed',
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontFamily: 'Raleway',
                  fontSize: 40)),
          SizedBox(
            height: 40,
          ),
          RawMaterialButton(
            onPressed: () {
              state.clearCart();
              Navigator.pop(context);
            },
            fillColor: Theme.of(context).accentColor,
            constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width, minHeight: 45),
            elevation: 0,
            child: Text(
              'Continue Shopping',
              style: TextStyle(fontFamily: 'Raleway', color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
