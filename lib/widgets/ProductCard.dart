import 'package:cool_store/models/product.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ProductDisplayCard extends StatelessWidget {
  final Function onPressed;
  final Product product;
  final double margin;

  ProductDisplayCard({@required this.onPressed, this.product, this.margin = 0});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(right: margin),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.transparent, Constants.lightBG.withOpacity(.1)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                margin: EdgeInsets.all(margin),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: ExtendedNetworkImageProvider(
                            product.featuredImage,
                            cache: true))),
              ),
            ),
            SizedBox(
              height: Constants.screenAwareSize(8, context),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                '${product.name}',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: Constants.screenAwareSize(12, context),
                    fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Rs. ${product.price}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Constants.screenAwareSize(10, context)),
              ),
            ),
            SizedBox(
              height: Constants.screenAwareSize(10, context),
            )
          ],
        ),
      ),
    );
  }
}
