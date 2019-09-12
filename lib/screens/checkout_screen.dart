import 'package:cool_store/models/product.dart';
import 'package:cool_store/screens/shipping_address_screen.dart';
import 'package:cool_store/screens/shipping_methods_screen.dart';
import 'package:flutter/material.dart';

// Todo add layout for address input and search for shipping
class Checkout extends StatefulWidget {
  final Map<String, int> productsInCart;
  final Map<String, ProductVariation> productVariationsInCart;

  Checkout({this.productsInCart, this.productVariationsInCart});

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int _currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CHECKOUT'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: PageView.builder(
          itemCount: 3,
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            switch (index) {
              case 0:
                return ShippingAddressScreen(
                  function: nextPage,
                );
              case 1:
                return ShippingMethodsScreen();
            }
            return Container();
          },
        ),
      )),
    );
  }

  nextPage() {
    _pageController.animateToPage(_currentPage++,
        duration: Duration(milliseconds: 400), curve: Curves.ease);
  }
}
