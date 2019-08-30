import 'package:cool_store/screens/detail_screen.dart';
import 'package:cool_store/states/product_list_state.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:cool_store/widgets/ProductCard.dart';
import 'package:cool_store/widgets/ShimmerGrid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatelessWidget {
  final int _categoryId, _totalProducts;
  final String _imageSrc, _categoryName;

  ProductListScreen(this._categoryId, this._imageSrc, this._categoryName,
      this._totalProducts);

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
                      title: Text('COOL STORE'),
                      bottom: PreferredSize(
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: FlatButton.icon(
                                  onPressed: () {},
                                  icon: Icon(Icons.sort),
                                  label: Text('SORT BY'),
                                )),
                                Container(
                                  width: 1,
                                  height: 15,
                                  color: Colors.black,
                                ),
                                Expanded(
                                    child: FlatButton.icon(
                                  onPressed: () {},
                                  label: Text('FILTER'),
                                  icon: Icon(Icons.tune),
                                ))
                              ],
                            ),
                          ),
                          preferredSize: Size(
                              100, Constants.screenAwareSize(40, context))),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      state.isLoading
                          ? ShimmerGrid()
                          : Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(17),
                                  child: Column(
                                    children: <Widget>[
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text:
                                                    ' NEW ARRIVALS - $_categoryName',
                                                style: DefaultTextStyle.of(
                                                        context)
                                                    .style
                                                    .copyWith(
                                                        fontFamily: 'Raleway',
                                                        fontWeight:
                                                            FontWeight.bold)),
                                            TextSpan(
                                                text: ' ( $_totalProducts )',
                                                style:
                                                    DefaultTextStyle.of(context)
                                                        .style
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w100))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(4),
                                        height: 2,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        color: Theme.of(context).accentColor,
                                      )
                                    ],
                                  ),
                                ),
                                GridView.builder(
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
                              ],
                            )
                    ]))
                  ],
                ),
              );
            },
          )),
    );
  }
}
