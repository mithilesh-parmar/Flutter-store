import 'package:cool_store/states/app_state.dart';
import 'package:cool_store/states/cart_state.dart';
import 'package:cool_store/widgets/CartItem.dart';
import 'package:cool_store/widgets/InfoView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CartState>(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            state.wishListCartProducts.length > 0
                ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.wishListCartProducts.length,
                    itemBuilder: (context, pos) {
//                      Product product =
//                          state.wishListProducts.keys.elementAt(pos);
//                      ProductVariation variation =
//                          state.wishListProducts.values.elementAt(pos);
                      final item = state.wishListCartProducts[pos];
                      final product = item.product;
                      final variation = item.productVariation;
                      return CartItem(
                        product: product,
                        variation: variation,
                        primaryTitle: 'Move to cart',
                        onRemovePressed: () {
                          state.removeProductFromWishList(item);
                        },
                        onPrimaryButtonPressed: () {
                          state.removeProductAndAddToCart(item);
                        },
                      );
                    })
                : buildEmptyView(theme, context)
          ]))
        ],
      ),
    );
  }

  Column buildEmptyView(ThemeData theme, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        InfoView(
          path: 'assets/list.svg',
          iconColor: theme.iconTheme.color.withOpacity(.8),
          primaryText: 'Empty wishlist',
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlatButton(
              color: theme.accentColor,
              onPressed: () {
                Navigator.pop(context);
                Provider.of<AppState>(context).navigateToHome();
              },
              child: Text(
                'START SHOPPING',
                style: TextStyle(color: Colors.white, fontFamily: 'Raleway'),
              )),
        )
      ],
    );
  }
}
