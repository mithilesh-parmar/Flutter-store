class PaymentMethod {
  String id;
  String title;
  String description;
  bool enabled;

  PaymentMethod({this.id, this.title, this.description, this.enabled});

  PaymentMethod.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson["id"];
    title = parsedJson["title"];
    description = parsedJson["description"];
    enabled = parsedJson["enabled"];
  }
}
