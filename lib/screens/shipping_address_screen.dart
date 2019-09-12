import 'package:cool_store/models/payment.dart';
import 'package:cool_store/models/user.dart';
import 'package:flutter/material.dart';
import 'package:validate/validate.dart';

class ShippingAddressScreen extends StatefulWidget {
  final Function function;

  ShippingAddressScreen({@required this.function});

  @override
  _ShippingAddressScreenState createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  Address address = Address(
      firstName: 'Mithilesh',
      lastName: 'Parmar',
      email: 'mithileshparmar1@gmail.com',
      street: 'VIT Road',
      city: 'Jaipur',
      country: 'in',
      phoneNumber: '123123',
      zipCode: '343905',
      state: 'Rajasthan');
  PaymentMethod paymentMethod = PaymentMethod(
      id: '1', title: 'cod', description: 'cash on delivery', enabled: true);

  TextEditingController _cityController = TextEditingController(text: 'jaipur');
  TextEditingController _streetController = TextEditingController(text: 'vit road');
  TextEditingController _zipController = TextEditingController(text: '343905');
  TextEditingController _stateController = TextEditingController(text: 'rajasthan');
  TextEditingController _countryController = TextEditingController(text: 'IN');

  final FocusNode _firstNameNode = FocusNode(),
      _lastNameNode = FocusNode(),
      _countryNode = FocusNode(),
      _numberNode = FocusNode(),
      _emailNode = FocusNode(),
      _stateNode = FocusNode(),
      _cityNode = FocusNode(),
      _streetNode = FocusNode(),
      _zipNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).accentColor.withOpacity(.9);
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
                initialValue: address.firstName,
                textInputAction: TextInputAction.next,
                focusNode: _firstNameNode,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(context, _firstNameNode, _lastNameNode);
                },
                decoration: InputDecoration(
                    labelText: 'First name',
                    labelStyle: TextStyle(color: accentColor)),
                validator: (val) {
                  return val.isEmpty ? 'first name is required' : null;
                },
                onSaved: (String value) {
                  address.firstName = value;
                }),
            TextFormField(
                initialValue: address.lastName,
                focusNode: _lastNameNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    _fieldFocusChange(context, _lastNameNode, _numberNode),
                validator: (val) {
                  return val.isEmpty ? 'last name is required' : null;
                },
                decoration: InputDecoration(
                    labelText: 'Lastname',
                    labelStyle: TextStyle(color: accentColor)),
                onSaved: (String value) {
                  address.lastName = value;
                }),
            TextFormField(
                initialValue: address.phoneNumber,
                focusNode: _numberNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    _fieldFocusChange(context, _numberNode, _emailNode),
                validator: (val) {
                  return val.isEmpty ? 'phone number is required' : null;
                },
//                    keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Number',
                    labelStyle: TextStyle(color: accentColor)),
                onSaved: (String value) {
                  address.phoneNumber = value;
                }),
            TextFormField(
                initialValue: address.email,
                keyboardType: TextInputType.emailAddress,
                focusNode: _emailNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    _fieldFocusChange(context, _emailNode, _countryNode),
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
                  address.email = value;
                }),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: _countryController,
              focusNode: _countryNode,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) =>
                  _fieldFocusChange(context, _countryNode, _stateNode),
              validator: (val) {
                return val.isEmpty ? 'Country is required' : null;
              },
              decoration: InputDecoration(
                  labelText: 'Country',
                  labelStyle: TextStyle(color: accentColor)),
              onSaved: (String value) {
                address.state = value;
              },
            ),
            TextFormField(
              controller: _stateController,
              focusNode: _stateNode,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) =>
                  _fieldFocusChange(context, _stateNode, _cityNode),
              validator: (val) {
                return val.isEmpty ? 'State is required' : null;
              },
              decoration: InputDecoration(
                  labelText: 'State/Province',
                  labelStyle: TextStyle(color: accentColor)),
              onSaved: (String value) {
                address.state = value;
              },
            ),
            TextFormField(
              controller: _cityController,
              focusNode: _cityNode,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) =>
                  _fieldFocusChange(context, _cityNode, _streetNode),
              validator: (val) {
                return val.isEmpty ? 'City is required' : null;
              },
              decoration: InputDecoration(
                  labelText: 'City', labelStyle: TextStyle(color: accentColor)),
              onSaved: (String value) {
                address.city = value;
              },
            ),
            TextFormField(
                controller: _streetController,
                focusNode: _streetNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) =>
                    _fieldFocusChange(context, _streetNode, _zipNode),
                validator: (val) {
                  return val.isEmpty ? 'Street is required' : null;
                },
                decoration: InputDecoration(
                    labelText: 'Street name',
                    labelStyle: TextStyle(color: accentColor)),
                onSaved: (String value) {
                  address.street = value;
                }),
            TextFormField(
                controller: _zipController,
                focusNode: _zipNode,
                textInputAction: TextInputAction.done,
//                    onFieldSubmitted: (_)=>_fieldFocusChange(context, _lastNameNode, _numberNode),
                validator: (val) {
                  return val.isEmpty ? 'Zip code is required' : null;
                },
                keyboardType: TextInputType.numberWithOptions(
                  signed: true,
                ),
                decoration: InputDecoration(
                    labelText: 'Zip code',
                    labelStyle: TextStyle(color: accentColor)),
                onSaved: (String value) {
                  address.zipCode = value;
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
                        widget.function();
                      }
                    },
//
                    color: Theme.of(context).accentColor,
                    child: Text(
                      'Review Order',
                      style:
                          TextStyle(color: Colors.white, fontFamily: "Raleway"),
                    ),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
