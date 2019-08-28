import 'package:cool_store/screens/detail_screen.dart';
import 'package:cool_store/states/product_list_state.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:cool_store/widgets/ProductCard.dart';
import 'package:cool_store/widgets/ShimmerGrid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatelessWidget {
  final int _categoryId;
  final String _imageSrc, _categoryName;

  ProductListScreen(this._categoryId, this._imageSrc, this._categoryName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
          builder: (_) => ProductListState(_categoryId),
          child: Consumer<ProductListState>(
            builder: (context, state, child) {
              return SafeArea(
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      expandedHeight: Constants.screenAwareSize(180, context),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(18),
                              child: Center(
                                child: Text(
                                  'SHOP FOR ${_categoryName}'.toUpperCase(),
                                  overflow: TextOverflow.fade,
                                  maxLines: 3,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontFamily: 'Raleway', fontSize: 34),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.transparent,
                                      Theme.of(context)
                                          .primaryColor
                                          .withOpacity(.7)
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      state.isLoading
                          ? ShimmerGrid()
                          : GridView.builder(
                              itemCount: state.products.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: .6,
                                      mainAxisSpacing: 2,
                                      crossAxisSpacing: 2),
                              itemBuilder: (context, pos) {
                                return ProductDisplayCard(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => DetailScreen(
                                                state.products[pos]),
                                            fullscreenDialog: true));
                                  },
                                  product: state.products[pos],
                                );
                              })
                    ]))
                  ],
                ),
              );
            },
          )),
    );
  }
}
