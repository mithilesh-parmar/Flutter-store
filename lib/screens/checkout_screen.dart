import 'package:cool_store/models/payment.dart';
import 'package:cool_store/models/product.dart';
import 'package:cool_store/models/user.dart';
import 'package:cool_store/states/cart_state.dart';
import 'package:cool_store/states/checkout_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Checkout extends StatelessWidget {
  Map<String, int> productsInCart;
  Map<String, ProductVariation> productVariationsInCart;
  Address address;
  PaymentMethod paymentMethod;

  Checkout({this.productsInCart, this.productVariationsInCart}) {
    address = Address(
        firstName: 'Mithilesh',
        lastName: 'Parmar',
        email: 'mithileshparmar1@gmail.com',
        street: 'VIT Road',
        city: 'Jaipur',
        country: 'in',
        phoneNumber: '123123',
        zipCode: '343905',
        state: 'Rajasthan');
    paymentMethod = PaymentMethod(
        id: '1', title: 'cod', description: 'cash on delivery', enabled: true);
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CheckoutState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('CHECKOUT'),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          children: <Widget>[
            FlatButton(
                textColor: Colors.white,
                color: Colors.redAccent,
                onPressed: () {
                  state.createOrder(productsInCart, productVariationsInCart,
                      address, paymentMethod);
                },
                child: Text('PROCEED')),
            Text('${productsInCart}')
          ],
        ),
      )),
    );
  }
}
