import 'package:cool_store/models/category.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CategoryBanner extends StatelessWidget {
  final Category _category;
  final Function _onPressed;

  CategoryBanner(this._category, this._onPressed);

  @override
  Widget build(BuildContext context) {
    double height = (MediaQuery.of(context).size.height) / 4.5;
    return InkWell(
      onTap: _onPressed,
      child: Stack(
        children: <Widget>[
          Container(
            height: Constants.screenAwareSize(height, context),
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: ExtendedNetworkImageProvider(_category.image,
                        cache: true))),
          ),
          Container(
            height: Constants.screenAwareSize(height, context),
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black54]),
            ),
          ),
          Container(
            height: Constants.screenAwareSize(height, context),
            margin: EdgeInsets.all(4),
            child: Center(
                child: Container(
              padding: EdgeInsets.all(8),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              child: Text(
                _category.name,
                style: TextStyle(
                    fontSize: Constants.screenAwareSize(40, context),
                    fontFamily: 'Raleway',
                    color: Colors.white),
              ),
            )),
          )
        ],
      ),
    );
  }
}
