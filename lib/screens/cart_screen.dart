import 'package:badges/badges.dart';
import 'package:cool_store/screens/checkout_screen.dart';
import 'package:cool_store/screens/detail_screen.dart';
import 'package:cool_store/screens/wishlist_screen.dart';
import 'package:cool_store/states/app_state.dart';
import 'package:cool_store/states/cart_state.dart';
import 'package:cool_store/states/checkout_state.dart';
import 'package:cool_store/utils/constants.dart';

import 'package:cool_store/widgets/CartItem.dart';
import 'package:cool_store/widgets/InfoView.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

// TODO change total
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Text(
                    'Cart',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway',
                        fontSize: 40),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => WishListScreen(),
                        fullscreenDialog: true));
                  },
                  child: Badge(
                    elevation: 0,
                    showBadge: state.wishListCartProducts.length != 0,
                    badgeContent: Text(
                      '${state.wishListCartProducts.length}',
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                    badgeColor: Theme.of(context).primaryColor,
                    animationType: BadgeAnimationType.scale,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                    ),
                  ),
                )
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 17, vertical: 8),
          ),
          state.cartProducts.length > 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Total items ${state.cartProducts.length}',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Raleway',
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 17, vertical: 2),
                    ),
                    buildCartListView(state),
                    Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // coupon view

//                          buildCouponView(context, state),

//                          Padding(
//                            padding: const EdgeInsets.only(top: 18.0),
//                            child: ListTile(
//                              leading: Text('Total'),
//                              trailing: Text('${state.totalCartAmount}'),
//                            ),
//                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChangeNotifierProvider<CheckoutState>(
                                              builder: (_) => CheckoutState(),
                                              child: Checkout(
                                                productsInCart:
                                                    state.productsInCart,
                                                productVariationsInCart: state
                                                    .productVariationsInCart,
                                              )),
                                      fullscreenDialog: true));
                            },
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
              : buildEmptyCartView(context, state)
        ]))
      ],
    ));
  }

  Container buildCouponView(BuildContext context, CartState state) {
    return Container(
      height: Constants.screenAwareSize(35, context),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[600])),
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: TextField(
              onChanged: (value) {
//                                      state.setCouponCode(value);
              },
              onSubmitted: (value) {
                // TODO check for code
                state.setCouponCode(value);
              },
              decoration: InputDecoration(
                  hintText: 'Coupon Code',
                  hintStyle: TextStyle(
                      fontFamily: 'Raleway',
                      color: Theme.of(context).textTheme.subhead.color),
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none),
            ),
          ),
          Expanded(
            child: FlatButton.icon(
                onPressed: () {},
                icon: Icon(Icons.local_offer),
                label: Text('Apply')),
          )
        ],
      ),
    );
  }

  ListView buildCartListView(CartState state) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: state.cartProducts.length,
        itemBuilder: (context, pos) {
          final item = state.cartProducts[pos];
          final product = item.product;
          final variation = item.productVariation;
          final quantity = item.quantity;
          return CartItem(
            product: product,
//            quantity: state.productsInCart[product.id.toString()],
            variation: variation,
            quantity: quantity,
            onPrimaryButtonPressed: () {
//              state.addProductToWishList(product, variation);
              state.addProductToWishList(item);
            },
            onRemovePressed: () {
              state.removeProductFromCart(item);
            },
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailScreen(product),
                  fullscreenDialog: true));
            },
          );
        });
  }

  Column buildEmptyCartView(BuildContext context, CartState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        InfoView(
          iconColor: Theme.of(context).iconTheme.color.withOpacity(.9),
          path: 'assets/shoppint_cart_empty.svg',
          primaryText: 'Looks like you haven\'t made your choice yet !',
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: FlatButton(
                color: Theme.of(context).accentColor,
                onPressed: () {
                  Provider.of<AppState>(context).navigateToHome();
                },
                child: Text(
                  'CONTINUE SHOPPING',
                  style: TextStyle(color: Colors.white, fontFamily: 'Raleway'),
                ))),
        if (state.wishListProducts.length > 0)
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => WishListScreen(),
                        fullscreenDialog: true));
                  },
                  child: Text(
                    'WISHLIST',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontFamily: 'Raleway'),
                  ))),
      ],
    );
  }
}
