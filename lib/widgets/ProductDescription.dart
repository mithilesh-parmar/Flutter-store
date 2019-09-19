import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:cool_store/models/product.dart';
import 'package:cool_store/states/detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';

class ProductDescription extends StatelessWidget {
  final Product product;
  final textStyle = TextStyle(fontFamily: 'Raleway');

  ProductDescription(this.product);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<DetailState>(context);
    bool enableReview = true;

    return Column(
      children: <Widget>[
        SizedBox(height: 15),
        ExpansionInfo(
            title: 'DESCRIPTION',
            children: <Widget>[
              HtmlWidget(
                product.description,
                textStyle: textStyle,
              ),
            ],
            expand: true),
        if (enableReview)
          Container(
              height: 1, decoration: BoxDecoration(color: Colors.grey[200])),
        if (enableReview)
          ExpansionInfo(
            title: 'REVIEWS',
            children: <Widget>[
              state.isReviewsLoading
                  ? CircularProgressIndicator()
                  : state.reviews.length > 0
                      ? ListTile(
                          title: Text(state.reviews[0].review),
                        )
                      : ListTile(
                          title: Text('No Reviews'),
                        )
            ],
          ),
        Container(
            height: 1, decoration: BoxDecoration(color: Colors.grey[200])),
        ExpansionInfo(
          title: 'ADDITIONAL INFO',
          children: <Widget>[
            HtmlWidget(
              product.description,
              textStyle: textStyle,
            )
          ],
        ),
      ],
    );
  }
}

class ExpansionInfo extends StatelessWidget {
  final String title;
  final bool expand;
  final List<Widget> children;

  ExpansionInfo(
      {@required this.title, @required this.children, this.expand = false});

  @override
  Widget build(BuildContext context) {
    return ConfigurableExpansionTile(
      initiallyExpanded: expand,
      headerExpanded: Flexible(
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 17.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(title,
                      style: TextStyle(fontSize: 17, fontFamily: 'Raleway')),
                  Icon(
                    Icons.keyboard_arrow_up,
                    size: 20,
                  )
                ])),
      ),
      header: Flexible(
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 17.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(title,
                      style: TextStyle(fontSize: 17, fontFamily: 'Raleway')),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 20,
                  )
                ])),
      ),
      children: children,
    );
  }
}
