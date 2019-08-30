import 'package:cool_store/models/product.dart';
import 'package:cool_store/states/detail_state.dart';
import 'package:cool_store/widgets/ShimmerList.dart';
import 'package:cool_store/widgets/ImageView.dart';
import 'package:cool_store/widgets/ProductCard.dart';
import 'package:cool_store/widgets/ProductDescription.dart';
import 'package:cool_store/widgets/ProductTitle.dart';
import 'package:cool_store/widgets/QuantityChooser.dart';
import 'package:cool_store/widgets/VariationsView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final Product _product;

  DetailScreen(this._product);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        builder: (_) => DetailState(widget._product.id),
        child: Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Theme.of(context).primaryColor,
                  elevation: 0,
                  title: Text(
                    widget._product.name,
                    style: TextStyle(
                        fontFamily: 'Raleway', fontWeight: FontWeight.w500),
                  ),
                  centerTitle: false,
                  pinned: true,
                  floating: false,
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  ImageView(),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Column(
                      children: <Widget>[
                        ProductTitle(widget._product),
                        VariationsView(widget._product),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: Consumer<DetailState>(
                                  builder: (context, state, child) {
                                return FlatButton.icon(
                                    onPressed: () {
                                      try {
                                        state.addToCart(context);
                                        _showSnackbar(context, 'ADDED TO CART');
                                      } catch (e) {
                                        _showSnackbar(context, e.toString());
                                      }
                                    },
                                    textColor: Colors.white,
                                    color: Theme.of(context).accentColor,
                                    icon: Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      'ADD TO CART',
                                    ));
                              }),
                            ),
                            Expanded(
                              child: QuantityChooser(),
                            )
                          ],
                        ),
                        ProductDescription(widget._product),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'YOU MIGHT LIKE',
                                style: TextStyle(
                                    fontFamily: 'Raleway', fontSize: 14),
                              ),
                            ),
                            Consumer<DetailState>(
                                builder: (context, state, child) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height / 2.7,
                                child: state.isRelatedProductsLoading
                                    ? ShimmerList(
                                        direction: Axis.horizontal,
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: state.relatedProducts.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, pos) {
                                          return ProductDisplayCard(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      fullscreenDialog: true,
                                                      builder: (context) =>
                                                          DetailScreen(state
                                                                  .relatedProducts[
                                                              pos])));
                                            },
                                            product: state.relatedProducts[pos],
                                            margin: 2,
                                          );
                                        }),
                              );
                            })
                          ],
                        )
                      ],
                    ),
                  ),
                ]))
              ],
            ),
          ),
        ));
  }

  _showSnackbar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(
        SnackBar(duration: Duration(seconds: 1), content: Text(text)));
  }
}
