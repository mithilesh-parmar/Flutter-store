import 'package:cool_store/states/checkout_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShippingMethodsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CheckoutState>(context);

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Choose Shipping Method',
            textAlign: TextAlign.start,
            style: TextStyle(fontFamily: 'Raleway-bold', fontSize: 28),
          ),
        ),
        state.isShippingMethodsLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                shrinkWrap: true,
                itemCount: state.shippingMethods.length,
                itemBuilder: (_, pos) {
                  final item = state.shippingMethods[pos];
                  return ListTile(
                    title: Text(
                      '${item.title}',
                      style: TextStyle(
                          fontFamily: "Raleway",
                          color: state.selectedShippingMethod.isEqual(item)
                              ? Theme.of(context).accentColor
                              : Colors.black),
                    ),
                    subtitle: Text(
                      '${item.description}',
                      style: TextStyle(fontFamily: "Raleway"),
                    ),
                    onTap: () {
                      state.setShippingMethod(item);
                    },
                  );
                },
                separatorBuilder: (__, _) => Divider(),
              ),
      ],
    );
  }
}
