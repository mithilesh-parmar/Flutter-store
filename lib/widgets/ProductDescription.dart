import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:cool_store/models/product.dart';
import 'package:cool_store/states/detail_state.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

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
              Align(
                alignment: Alignment.topLeft,
                child: HtmlWidget(
                  product.description,
                  textStyle: textStyle,
                ),
              ),
            ],
            expand: true),
        if (enableReview)
          Container(
              height: 1, decoration: BoxDecoration(color: Colors.grey[200])),
        if (enableReview)
          ExpansionInfo(
              title: 'REVIEWS',
              children: state.isReviewsLoading
                  ? [CircularProgressIndicator()]
                  : state.doesContainReviews
                      ? state
                          .getTopReviews()
                          .map((Review review) => ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    HtmlWidget(
                                      review.reviewer,
                                      textStyle: TextStyle(
                                        fontFamily: 'Raleway',
                                      ),
                                      bodyPadding: EdgeInsets.symmetric(
                                          horizontal: 2, vertical: 2),
                                    ),
                                    SmoothStarRating(
                                        allowHalfRating: true,
                                        starCount: review.rating,
                                        rating: product.averageRating,
                                        size: Constants.screenAwareSize(
                                            10, context),
                                        color: Theme.of(context).accentColor,
                                        borderColor:
                                            Theme.of(context).accentColor,
                                        spacing: 0.0),
                                  ],
                                ),
                                subtitle: HtmlWidget(
                                  review.review,
                                  textStyle: TextStyle(
                                    fontFamily: 'Raleway',
                                  ),
                                  bodyPadding: EdgeInsets.symmetric(
                                      horizontal: 2, vertical: 2),
                                ),
                                dense: true,
                              ))
                          .toList()
                      : [
                          ListTile(
                            title: Text(
                              'No Reviews yet',
                              style: TextStyle(
                                  fontFamily: 'Raleway', fontSize: 14),
                            ),
                          )
                        ]
//            children: <Widget>[
//              state.isReviewsLoading
//                  ? CircularProgressIndicator()
//                  : state.reviews.length > 0
//                      ? ListView.builder(
//                          physics: NeverScrollableScrollPhysics(),
//                          itemBuilder: (_, pos) {
//                            Review review = state.reviews[pos];
//                            return ListTile(
//                              title: HtmlWidget(review.reviewer),
//                              subtitle: HtmlWidget(review.review),
//                            );
//                          },
//                          itemCount: state.reviews.length,
//                        )
//                      : ListTile(
//                          title: Text('No Reviews'),
//                        )
//            ],
              ),
        Container(
            height: 1, decoration: BoxDecoration(color: Colors.grey[200])),
        ExpansionInfo(
          title: 'ADDITIONAL INFO',
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: HtmlWidget(
                product.description,
                textStyle: textStyle,
              ),
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
