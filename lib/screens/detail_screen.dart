import 'package:cool_store/models/product.dart';
import 'package:cool_store/services/base_services.dart';
import 'package:cool_store/states/detail_state.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:cool_store/widgets/ImageView.dart';
import 'package:cool_store/widgets/ProductCard.dart';
import 'package:cool_store/widgets/ProductDescription.dart';
import 'package:cool_store/widgets/ProductTitle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final Product _product;

  DetailScreen(this._product);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Future<List<Product>> getRelatedProducts() async {
    return Services().fetchProductsByCategory(
        categoryId: widget._product.categoryId, page: 1);
  }

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
                  expandedHeight: Constants.screenAwareSize(330, context),
                  flexibleSpace: FlexibleSpaceBar(
                    background: ImageView(),
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Column(
                      children: <Widget>[
                        ProductTitle(widget._product),
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
                            FutureBuilder(
                                future: getRelatedProducts(),
                                builder: (context, snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.none:
                                      // TODO: Handle this case.
                                      break;
                                    case ConnectionState.waiting:
                                      return CircularProgressIndicator();
                                    case ConnectionState.active:
                                      // TODO: Handle this case.
                                      break;
                                    case ConnectionState.done:
                                      if (snapshot.hasError)
                                        return Center(
                                          child: Text('${snapshot.error}'),
                                        );
                                      return Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: snapshot.data.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, pos) {
                                              return ProductDisplayCard(
                                                onPressed: () {},
                                                product: snapshot.data[pos],
                                                margin: 2,
                                              );
                                            }),
                                      );
                                  }
                                  return Container();
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
}
