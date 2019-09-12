import 'package:cool_store/models/product.dart';
import 'package:cool_store/screens/order_review_screen.dart';
import 'package:cool_store/screens/order_summary_screen.dart';
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
          itemCount: 4,
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            switch (index) {
              case 0:
                return ShippingAddressScreen(
                  function: nextPage,
                );
              case 1:
                return ShippingMethodsScreen(
                  onNextPressed: nextPage,
                  onBackPressed: previousPage,
                );
              case 2:
                return OrderReview(
                  onButtonClicked: nextPage,
                );
              case 3:
                return OrderSummary();
            }
            return Container();
          },
        ),
      )),
    );
  }

  nextPage() {
    print('Next page $_currentPage');
    if (_currentPage == 3) return;
    setState(() {
      _currentPage++;
      _pageController.animateToPage(_currentPage,
          duration: Duration(milliseconds: 400), curve: Curves.ease);
    });
  }

  previousPage() {
    print('prev page $_currentPage');
    if (_currentPage == 0) return;
    setState(() {
      _currentPage--;
      _pageController.animateToPage(_currentPage,
          duration: Duration(milliseconds: 400), curve: Curves.ease);
    });
  }
}
