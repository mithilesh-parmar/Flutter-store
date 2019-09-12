import 'package:cool_store/states/checkout_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShippingMethodsScreen extends StatelessWidget {
  final Function onNextPressed;
  final Function onBackPressed;

  ShippingMethodsScreen(
      {@required this.onNextPressed, @required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CheckoutState>(context);

    return SingleChildScrollView(
      child: Column(
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
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_, pos) {
                    final item = state.shippingMethods[pos];
                    return ListTile(
                      isThreeLine: true,
                      leading: state.selectedShippingMethod.isEqual(item)
                          ? Icon(
                              Icons.check,
                              color: Theme.of(context).accentColor,
                            )
                          : Icon(Icons.radio_button_unchecked),
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
          SizedBox(
            height: 30,
          ),
          RawMaterialButton(
            onPressed: onNextPressed,
            constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width, minHeight: 45),
            fillColor: Theme.of(context).accentColor,
            elevation: 0,
            child: Text(
              'REVIEW ORDER',
              style: TextStyle(fontFamily: 'Raleway', color: Colors.white),
            ),
          ),
          RawMaterialButton(
            onPressed: onBackPressed,
            constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width, minHeight: 25),
            elevation: 0,
            child: Text(
              'EDIT ADDRESS',
              style: TextStyle(
                  fontFamily: 'Raleway', color: Theme.of(context).accentColor),
            ),
          ),
        ],
      ),
    );
  }
}
