import 'package:cool_store/models/category.dart';
import 'package:cool_store/screens/detail_screen.dart';
import 'package:cool_store/states/product_list_state.dart';
import 'package:cool_store/utils/constants.dart';
import 'package:cool_store/widgets/ProductCard.dart';
import 'package:cool_store/widgets/ShimmerGrid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatelessWidget {
  final Category category;

  ProductListScreen({this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
          builder: (_) => ProductListState(category.id),
          child: Consumer<ProductListState>(
            builder: (context, state, child) {
              return SafeArea(
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      title: Text('COOL STORE'),
                      bottom: buildPreferenceView(context, state),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      state.isLoading
                          ? ShimmerGrid()
                          : Column(
                              children: <Widget>[
                                buildDecorationView(context),
                                buildCategoryProductsView(state)
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

  GridView buildCategoryProductsView(ProductListState state) {
    return GridView.builder(
        itemCount: state.products.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                      builder: (_) => DetailScreen(state.products[pos]),
                      fullscreenDialog: true));
            },
            product: state.products[pos],
          );
        });
  }

  Container buildDecorationView(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(17),
      child: Column(
        children: <Widget>[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: ' NEW ARRIVALS - ${category.name}',
                    style: DefaultTextStyle.of(context).style.copyWith(
                        fontFamily: 'Raleway', fontWeight: FontWeight.bold)),
                TextSpan(
                    text: ' ( ${category.totalProduct} )',
                    style: DefaultTextStyle.of(context)
                        .style
                        .copyWith(fontWeight: FontWeight.w100))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(4),
            height: 2,
            width: MediaQuery.of(context).size.width / 4,
            color: Theme.of(context).accentColor,
          )
        ],
      ),
    );
  }

  PreferredSize buildPreferenceView(
      BuildContext context, ProductListState state) {
    return PreferredSize(
        child: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                  child: FlatButton.icon(
                onPressed: () {
                  _showOptions(context, [
//                    'SORT BY',
                    'POPULAR',
                    'NEW',
                    'PRICE: LOW TO HIGH',
                    'PRICE: HIGH TO LOW'
                  ]);
                },
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
        preferredSize: Size(100, Constants.screenAwareSize(40, context)));
  }

  _showOptions(context, List<String> options) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: options
                  .map((value) => ListTile(
                        onTap: () {
                          Navigator.of(context).pop(value);
                        },
                        title: Center(
                            child: Text(
                          value,
                          style: TextStyle(fontFamily: 'Raleway', fontSize: 14),
                        )),
                      ))
                  .toList(),
            ),
          );
        });
  }
}
