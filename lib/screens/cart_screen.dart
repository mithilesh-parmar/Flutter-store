import 'package:cool_store/models/product.dart';
import 'package:cool_store/screens/detail_screen.dart';
import 'package:cool_store/states/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartState state = Provider.of<CartState>(context);
    return SafeArea(
        child: CustomScrollView(
      slivers: <Widget>[
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
            child: Text(
              'Cart',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway',
                  fontSize: 40),
            ),
            padding: EdgeInsets.symmetric(horizontal: 17, vertical: 8),
          ),
          Container(
            child: Text(
              'Total items ${state.products.length}',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontFamily: 'Raleway',
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 17, vertical: 2),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: state.products.length,
              itemBuilder: (context, pos) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {

                      },
                      leading: Image.network(state.products[pos].featuredImage),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Rs ${state.products[pos].price}'),
                          Text('${state.attributes[pos]}'),
                          Text('Qty: ${state.quantities[pos]}')
                        ],
                      ),
                      title: Text(
                        state.products[pos].name,
                        style: TextStyle(
                          fontFamily: 'Rlaleway',
                        ),
                      ),
                      isThreeLine: true,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: RawMaterialButton(
                            onPressed: () {
                              state.removeProduct(pos);
                            },
                            child: Text('REMOVE'),
                          ),
                        ),
                        Expanded(
                          child: RawMaterialButton(
                            onPressed: () {
                              state.addToWishList(pos);
                            },
                            fillColor: Theme.of(context).accentColor,
                            child: Text('WISHLIST'),
                            textStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey[400],
                    )
                  ],
                );
              }),
        ]))
      ],
    ));
  }
}
