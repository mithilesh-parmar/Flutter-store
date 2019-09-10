import 'package:cool_store/models/payment.dart';
import 'package:cool_store/models/product.dart';
import 'package:cool_store/models/user.dart';
import 'package:cool_store/states/checkout_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validate/validate.dart';

// Todo add layout for address input and search for shipping
class Checkout extends StatefulWidget {
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
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _cityController = TextEditingController();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _zipController = TextEditingController();
  TextEditingController _stateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CheckoutState>(context);
    final accentColor = Theme.of(context).accentColor.withOpacity(.9);
    return Scaffold(
      appBar: AppBar(
        title: Text('CHECKOUT'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                  initialValue: widget.address.firstName,
                  decoration: InputDecoration(
                      labelText: 'First name',
                      labelStyle: TextStyle(color: accentColor)),
                  validator: (val) {
                    return val.isEmpty ? 'first name is required' : null;
                  },
                  onSaved: (String value) {
                    widget.address.firstName = value;
                  }),
              TextFormField(
                  initialValue: widget.address.lastName,
                  validator: (val) {
                    return val.isEmpty ? 'last name is required' : null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Lastname',
                      labelStyle: TextStyle(color: accentColor)),
                  onSaved: (String value) {
                    widget.address.lastName = value;
                  }),
              TextFormField(
                  initialValue: widget.address.phoneNumber,
                  validator: (val) {
                    return val.isEmpty ? 'phone number is required' : null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Number',
                      labelStyle: TextStyle(color: accentColor)),
                  onSaved: (String value) {
                    widget.address.phoneNumber = value;
                  }),
              TextFormField(
                  initialValue: widget.address.email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: accentColor)),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Email is required';
                    }

                    try {
                      Validate.isEmail(val);
                    } catch (e) {
                      return 'Provide valid email';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    widget.address.email = value;
                  }),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: _stateController,
                validator: (val) {
                  return val.isEmpty ? 'State is required' : null;
                },
                decoration: InputDecoration(
                    labelText: 'State/Province',
                    labelStyle: TextStyle(color: accentColor)),
                onSaved: (String value) {
                  widget.address.state = value;
                },
              ),
              TextFormField(
                controller: _cityController,
                validator: (val) {
                  return val.isEmpty ? 'City is required' : null;
                },
                decoration: InputDecoration(
                    labelText: 'City',
                    labelStyle: TextStyle(color: accentColor)),
                onSaved: (String value) {
                  widget.address.city = value;
                },
              ),
              TextFormField(
                  controller: _streetController,
                  validator: (val) {
                    return val.isEmpty ? 'Street is required' : null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Street name',
                      labelStyle: TextStyle(color: accentColor)),
                  onSaved: (String value) {
                    widget.address.street = value;
                  }),
              TextFormField(
                  controller: _zipController,
                  validator: (val) {
                    return val.isEmpty ? 'Zip code is required' : null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Zip code',
                      labelStyle: TextStyle(color: accentColor)),
                  onSaved: (String value) {
                    widget.address.zipCode = value;
                  }),
              SizedBox(height: 20),
              Row(children: [
                Expanded(
                  child: ButtonTheme(
                    height: 45,
                    child: RaisedButton(
                      elevation: 0.0,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          print('address: ${widget.address}');
//                        Provider.of<CartModel>(context).setAddress(address);
//                        widget.onNext();
                        }
                      },
//
                      color: Theme.of(context).accentColor,
                      child: Text(
                        'Continue to shipping',
                        style: TextStyle(
                            color: Colors.white, fontFamily: "Raleway"),
                      ),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      )),
    );
  }
}
