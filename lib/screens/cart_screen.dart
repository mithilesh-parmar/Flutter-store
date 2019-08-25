import 'package:cool_store/models/product.dart';
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
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: state.products.length,
              itemBuilder: (context, pos) {
                return ListTile(
                  leading: Image.network(state.products[pos].featuredImage),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Rs ${state.products[pos].price}'),
                      Text('${state.attributes[pos]}'),
                      Text(state.quantities[pos])
                    ],
                  ),
                  title: Text(state.products[pos].name),
                  isThreeLine: true,
                  dense: true,
                );
              }),
        ]))
      ],
    ));
  }
}
