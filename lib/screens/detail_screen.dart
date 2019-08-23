import 'package:cool_store/models/product.dart';
import 'package:cool_store/services/base_services.dart';
import 'package:cool_store/states/detail_state.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:cool_store/widgets/ImageView.dart';
import 'package:cool_store/widgets/ProductCard.dart';
import 'package:cool_store/widgets/ProductDescription.dart';
import 'package:cool_store/widgets/ProductTitle.dart';
import 'package:cool_store/widgets/RelatedProducts.dart';
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
    return Services()
        .fetchProductsByCategory(categoryId: widget._product.categoryId);
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
                  elevation: 1,
                  actions: <Widget>[Icon(Icons.share)],
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
//                        Container(
//                          height: MediaQuery.of(context).size.height * 0.7,
//                          child: FutureBuilder(
//                              future: getRelatedProducts(),
//                              builder: (context, snapshot) {
//                                switch (snapshot.connectionState) {
//                                  case ConnectionState.none:
//                                    return Container();
//                                  case ConnectionState.waiting:
//                                    // TODO: Handle this case.
//                                    return Container(
//                                      child: Center(
//                                        child: CircularProgressIndicator(),
//                                      ),
//                                    );
//                                  case ConnectionState.active:
//                                    // TODO: Handle this case.
//                                    return Container();
//                                  case ConnectionState.done:
//                                    if (snapshot.hasError)
//                                      return Center(
//                                        child: Text('${snapshot.error}'),
//                                      );
//
//                                    return ListView.builder(
//                                        itemBuilder: (context, pos) {
//                                      return ProductDisplayCard(
//                                        onPressed: () {},
//                                        product: snapshot.data[pos],
//                                      );
//                                    });
//                                }
//                              }),
//                        )
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
