import 'package:cool_store/states/cart_state.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Badge extends StatelessWidget {
  final String count;
  final IconData iconData;
  final TextStyle style;
  final Color countBackgroundColor;

  Badge({this.count, this.iconData, this.style, this.countBackgroundColor});

  @override
  Widget build(BuildContext context) {
    final length = Provider.of<CartState>(context).wishListProducts.length;
    ThemeData themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Stack(
          children: <Widget>[
            Icon(
              iconData,
              size: Constants.screenAwareSize(20, context),
            ),
            Positioned(
                bottom: 5,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: length > 0
                          ? countBackgroundColor ??
                              Colors.redAccent.withOpacity(.7)
                          : Colors.transparent),
                  child: Text(
                    '${length > 0 ? length : ''}',
                    style: style ??
                        TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
