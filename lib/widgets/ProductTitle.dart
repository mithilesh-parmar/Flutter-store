import 'package:cool_store/models/product.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductTitle extends StatelessWidget {
  final Product product;

  ProductTitle(this.product);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Text(
            product.name,
            style: TextStyle(fontSize: 18, fontFamily: 'Raleway'),
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
//            Text(Tools.getCurrecyFormatted(price),
//                style: Theme.of(context)
//                    .textTheme
//                    .headline
//                    .copyWith(fontSize: 17, color: theme.accentColor)),
            Text(
              product.price,
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            if (product.onSale)
              SizedBox(width: 5),
            if (product.onSale)
              Text(
                product.regularPrice,
                style: TextStyle(fontSize: 16),
              ),
//              Text(Tools.getCurrecyFormatted(regularPrice),
//                  style: Theme.of(context).textTheme.headline.copyWith(
//                      fontSize: 16,
//                      color: Theme.of(context).accentColor,
//                      decoration: TextDecoration.lineThrough)),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SmoothStarRating(
                  allowHalfRating: true,
                  starCount: 5,
                  rating: product.averageRating,
                  size: 17.0,
                  color: theme.accentColor,
                  borderColor: theme.accentColor,
                  spacing: 0.0),
            ],
          ),
        ),
      ],
    );
  }
}
