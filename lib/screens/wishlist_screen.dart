import 'package:cool_store/models/product.dart';
import 'package:cool_store/states/cart_state.dart';
import 'package:cool_store/widgets/CartItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CartState>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.wishListProducts.length,
                itemBuilder: (context, pos) {
                  Product product = state.wishListProducts.keys.elementAt(pos);
                  ProductVariation variation =
                      state.wishListProducts.values.elementAt(pos);
                  return CartItem(
                    product: product,
                    variation: variation,
                    primaryTitle: 'Move to cart',
                    onSecondaryButtonPressed: () {

                    },
                    onPrimaryButtonPressed: () {


                    },
                  );
                })
          ]))
        ],
      ),
    );
  }
}
