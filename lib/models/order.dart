import 'package:cool_store/models/payment.dart';
import 'package:cool_store/models/product.dart';
import 'package:cool_store/models/user.dart';
import 'package:cool_store/states/cart_state.dart';

class ProductItem {
  int productId;
  String name;
  int quantity;
  String total;

  ProductItem.fromJson(Map<String, dynamic> parsedJson) {
    productId = parsedJson["product_id"];
    name = parsedJson["name"];
    quantity = parsedJson["quantity"];
    total = parsedJson["total"];
  }
}

class Order {
  int id;
  String number;
  String status;
  DateTime createdAt;
  double total;
  String paymentMethodTitle;
  String shippingMethodTitle;
  List<ProductItem> lineItems = [];
  Address billing;

  Order({this.id, this.number, this.status, this.createdAt, this.total});

  Order.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson["id"];
    number = parsedJson["number"];
    status = parsedJson["status"];
    createdAt = parsedJson["date_created"] != null
        ? DateTime.parse(parsedJson["date_created"])
        : DateTime.now();
    total =
        parsedJson["total"] != null ? double.parse(parsedJson["total"]) : 0.0;
    paymentMethodTitle = parsedJson["payment_method_title"];

    parsedJson["line_items"].forEach((item) {
      lineItems.add(ProductItem.fromJson(item));
    });

    billing = Address.fromJson(parsedJson["billing"]);
    shippingMethodTitle = parsedJson["shipping_lines"][0]["method_title"];
  }

  Map<String, dynamic> toJson(
      Map<String, int> productsInCart,
      Map<String, ProductVariation> productVariationsInCart,
      Address address,
      PaymentMethod paymentMethod,
      [userId = 1]) {
    var lineItems = productsInCart.keys.map((key) {
      var productId = int.parse(key);
      var item = {"product_id": productId, "quantity": productsInCart[key]};
      if (productVariationsInCart[key] != null) {
        item['variation_id'] = productVariationsInCart[key].id;
      }

      return item;
    }).toList();

    return {
      "payment_method": paymentMethod.id,
      "payment_method_title": paymentMethod.title,
      "set_paid": false,
      "billing": address.toJson(),
      "shipping": address.toJson(),
      "line_items": lineItems,
      "customer_id": userId,
      "shipping_lines": [
        {"method_id": 'flat_rate', "method_title": 'Flat Rate'}
      ]
    };
  }

  @override
  String toString() => 'Order { id: $id  number: $number}';
}
