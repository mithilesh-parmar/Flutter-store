import 'package:cool_store/models/product.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  Function onTap, onWishlistPressed, onRemovePressed;

  Product product;
  ProductVariation variation;
  int quantity;

  CartItem(
      {this.onTap,
      this.onWishlistPressed,
      this.onRemovePressed,
      this.variation,
      this.product,
      this.quantity = 1});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: onTap,
          leading: Image.network(product.featuredImage),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('$variation'),
              Text('Qty: $quantity')
            ],
          ),
          title: Text(
            product.name,
            style: TextStyle(
              fontFamily: 'Rlaleway',
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                'Rs ${product.price}',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              )
            ],
          ),
          isThreeLine: true,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
          child: Row(
            children: <Widget>[
              Expanded(
                child: RawMaterialButton(
                  onPressed: onRemovePressed,
                  child: Text('REMOVE'),
                ),
              ),
              Expanded(
                child: RawMaterialButton(
                  onPressed: onWishlistPressed,
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
  }
}
