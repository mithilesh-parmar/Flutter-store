import 'package:cool_store/models/product.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final Function onTap, onSecondaryButtonPressed, onPrimaryButtonPressed;

  final String primaryTitle, secondaryTitle;
  final Product product;
  final ProductVariation variation;
  final int quantity;

  CartItem(
      {this.onTap,
      this.onSecondaryButtonPressed,
      this.onPrimaryButtonPressed,
      this.variation,
      this.product,
      this.primaryTitle = 'Add to wishlist',
      this.secondaryTitle = 'Remove',
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
                  onPressed: onSecondaryButtonPressed,
                  child: Text('$secondaryTitle'),
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
