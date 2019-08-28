import 'package:cool_store/models/product.dart';
import 'package:cool_store/screens/detail_screen.dart';
import 'package:cool_store/states/cart_state.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:cool_store/widgets/CartItem.dart';
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
          state.products.length > 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Total items ${state.productsInCart.length}',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Raleway',
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 17, vertical: 2),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.products.length,
                        itemBuilder: (context, pos) {
                          Product product =
                              state.products.values.elementAt(pos);
                          return CartItem(
                            product: product,
                            quantity: state.productsInCart[product.id.toString()],
                            variation:
                                state.productVariationsInCart[product.id.toString()],
                            onRemovePressed: () {},
                            onWishlistPressed: () {},
                            onTap: () {},
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
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: Constants.screenAwareSize(40, context),
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor),
                              child: Center(
                                child: Text(
                                  'CHECKOUT',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Image.asset(
                        'empty_cart.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        'Looks like you haven\'t made your choice yet !',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 40,
                            fontWeight: FontWeight.w200),
                      ),
                    )
                  ],
                )
        ]))
      ],
    ));
  }
}
