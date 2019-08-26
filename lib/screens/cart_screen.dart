import 'package:cool_store/screens/detail_screen.dart';
import 'package:cool_store/states/cart_state.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartState state = Provider.of<CartState>(context);
    return SafeArea(
        child: CustomScrollView(
      slivers: <Widget>[
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
            child: Text(
              'Cart',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway',
                  fontSize: 40),
            ),
            padding: EdgeInsets.symmetric(horizontal: 17, vertical: 8),
          ),
          Container(
            child: Text(
              'Total items ${state.products.length}',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontFamily: 'Raleway',
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 17, vertical: 2),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: state.products.length,
              itemBuilder: (context, pos) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    DetailScreen(state.products[pos])));
                      },
                      leading: Image.network(state.products[pos].featuredImage),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${state.attributes[pos]}'),
                          Text('Qty: ${state.quantities[pos]}')
                        ],
                      ),
                      title: Text(
                        state.products[pos].name,
                        style: TextStyle(
                          fontFamily: 'Rlaleway',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'Rs ${state.products[pos].price}',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          )
                        ],
                      ),
                      isThreeLine: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RawMaterialButton(
                              onPressed: () {
                                state.removeProduct(pos);
                              },
                              child: Text('REMOVE'),
                            ),
                          ),
                          Expanded(
                            child: RawMaterialButton(
                              onPressed: () {
                                state.addToWishList(pos);
                              },
                              fillColor: Theme.of(context).accentColor,
                              child: Text('WISHLIST'),
                              textStyle: TextStyle(color: Colors.white),
                              elevation: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Constants.screenAwareSize(15, context),
                    )
                  ],
                );
              }),
          Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Text('Total'),
                  trailing: Text('${state.totalCartAmount}'),
                ),
                ListTile(
                  leading: Text('Charges'),
                  trailing: Text('${state.totalCartExtraCharge}'),
                ),
                ListTile(
                  leading: Text('Payable'),
                  trailing: Text('${state.totalCartPayableAmount}'),
                ),
              ],
            ),
          ),
        ]))
      ],
    ));
  }
}
