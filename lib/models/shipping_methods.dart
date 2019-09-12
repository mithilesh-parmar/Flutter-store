class ShippingMethods {
  String id;
  String title;
  String description;

  ShippingMethods({this.id, this.title, this.description});

  toJson() {
    return {
      'method_id': id,
      'method_title': title,
    };
  }

  ShippingMethods.fromJson(Map<String, dynamic> parsedjson) {
    id = parsedjson['id'];
    title = parsedjson['title'];
    description = parsedjson['description'];
  }

  bool isEqual(ShippingMethods item) {
    return id == item.id &&
        title == item.title &&
        description == item.description;
  }
}
