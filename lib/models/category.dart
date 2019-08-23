import 'package:flutter/material.dart';

class Category {
  int id;
  String name;
  String image;
  int parent;
  int totalProduct;

  Category.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson["slug"] == 'uncategorized') {
      return;
    }

    id = parsedJson["id"];
    name = parsedJson["name"];
    parent = parsedJson["parent"];
    totalProduct = parsedJson["count"];

    final image = parsedJson["image"];
    if (image != null) {
      this.image = image["src"];
    } else {
      this.image = 'category_image_default.jpg';
    }
  }

  @override
  String toString() => 'Category { id: $id  name: $name}';
}
