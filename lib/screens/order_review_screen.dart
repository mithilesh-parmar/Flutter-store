import 'package:cool_store/models/product.dart';
import 'package:cool_store/states/cart_state.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:cool_store/widgets/CartItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'detail_screen.dart';

class OrderReview extends StatelessWidget {
  final Function onButtonClicked;

  OrderReview({this.onButtonClicked});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CartState>(context);
    return SingleChildScrollView(
      child: Column(
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
            padding: EdgeInsets.symmetric(horizontal: 17, vertical: 2),
          ),
          buildCartListView(state),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // coupon view
                buildCouponView(context, state),

                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: ListTile(
                    leading: Text('SUB TOTAL'),
                    trailing: Text('...'),
                  ),
                ),

                RawMaterialButton(
                  onPressed: onButtonClicked,
                  fillColor: Theme.of(context).accentColor,
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width,
                      minHeight: 45),
                  elevation: 0,
                  child: Text(
                    'PLACE ORDER',
                    style:
                        TextStyle(fontFamily: 'Raleway', color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
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
          Product testProduct = state.cartProducts[pos].product;
          ProductVariation testProductVariation =
              state.cartProducts[pos].productVariation;
          int quantity = state.cartProducts[pos].quantity;

          return CartItem(
            product: testProduct,
            variation: testProductVariation,
            quantity: quantity,
            onPrimaryButtonPressed: () {
              state.addProductToWishList(item);
            },
            onRemovePressed: () {
              state.removeProductFromCart(item);
            },
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailScreen(testProduct),
                  fullscreenDialog: true));
            },
          );
        });
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
}
