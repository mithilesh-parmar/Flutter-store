import 'package:cool_store/models/product.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final Function onTap, onRemovePressed, onPrimaryButtonPressed;

  final String primaryTitle;
  final Product product;
  final ProductVariation variation;
  final int quantity;

  CartItem(
      {this.onTap,
      this.onRemovePressed,
      this.onPrimaryButtonPressed,
      this.variation,
      this.product,
      this.primaryTitle = 'Add to wishlist',
      this.quantity = 1});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: onTap,
          leading: ExtendedImage.network(
            product.featuredImage,
            cache: true,
            fit: BoxFit.contain,
            constraints: BoxConstraints(
              maxHeight: Constants.screenAwareSize(60, context),
              maxWidth: Constants.screenAwareSize(60, context)
            ),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[Text('$variation'), Text('Qty: $quantity')],
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
                  onPressed: onPrimaryButtonPressed,
                  fillColor: Theme.of(context).accentColor,
                  child: Text('$primaryTitle'),
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
