import 'package:flutter/cupertino.dart';

class Product {
  int id;
  String sku;
  String name;
  String description;
  String permalink;
  String price;
  String regularPrice;
  String salePrice;
  bool onSale;
  bool inStock;
  double averageRating;
  double ratingCount;
  List<String> images;
  String featuredImage;
  List<ProductAttribute> attributes;
  int categoryId;

  Product.empty(int id) {
    this.id = id;
    name = 'Loading...';
    price = '0.0';
    featuredImage = '';
  }

  bool isEmptyProduct() {
    return name == 'Loading...' && price == '0.0' && featuredImage == '';
  }

  Product.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson["id"];
    name = parsedJson["name"];
    description = parsedJson["description"];
    permalink = parsedJson["permalink"];
    price = parsedJson["price"] == 0 ? 10 : parsedJson["price"];

    regularPrice = parsedJson["regular_price"];
    salePrice = parsedJson["sale_price"];
    onSale = parsedJson["on_sale"];
    inStock = parsedJson["in_stock"];

    averageRating = double.parse(parsedJson["average_rating"]);
    ratingCount = double.parse(parsedJson["rating_count"].toString());
    categoryId =
        parsedJson["categories"] != null && parsedJson["categories"].length > 0
            ? parsedJson["categories"][0]["id"]
            : 0;

    List<ProductAttribute> attributeList = [];
    parsedJson["attributes"].forEach((item) {
      attributeList.add(ProductAttribute.fromJson(item));
    });
    attributes = attributeList;

    List<String> list = [];
    for (var item in parsedJson["images"]) {
      list.add(item["src"]);
    }
    images = list;
    featuredImage = images[0];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "sku": sku,
      "name": name,
      "description": description,
      "permalink": permalink,
      "price": price,
      "regularPrice": regularPrice,
      "salePrice": salePrice,
      "onSale": onSale,
      "inStock": inStock,
      "averageRating": averageRating,
      "ratingCount": ratingCount,
      "images": images,
      "imageFeature": featuredImage,
      "attributes": attributes,
      "categoryId": categoryId
    };
  }

  Product.fromLocalJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      sku = json['sku'];
      name = json['name'];
      description = json['description'];
      permalink = json['permalink'];
      price = json['price'];
      regularPrice = json['regularPrice'];
      salePrice = json['salePrice'];
      onSale = json['onSale'];
      inStock = json['inStock'];
      averageRating = json['averageRating'];
      ratingCount = json['ratingCount'];
      List<String> imgs = [];
      for (var item in json['images']) {
        imgs.add(item);
      }
      images = imgs;
      featuredImage = json['imageFeature'];
      List<ProductAttribute> attrs = [];
      for (var item in json['attributes']) {
        attrs.add(ProductAttribute.fromLocalJson(item));
      }
      attributes = attrs;
      categoryId = json['categoryId'];
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  String toString() => 'Product { id: $id name: $name }';
}

class ProductAttribute {
  int id;
  String name;
  List options;

  ProductAttribute.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson["id"];
    name = parsedJson["name"];
    options = parsedJson["options"];
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "options": options};
  }

  @override
  String toString() {
    return 'id: $id name: $name options: $options';
  }

  ProductAttribute.fromLocalJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      name = json['name'];
      options = json['options'];
    } catch (e) {
      print(e.toString());
    }
  }
}

class Attribute {
  int id;
  String name;
  String option;

  Attribute();

  Attribute.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson["id"];
    name = parsedJson["name"];
    option = parsedJson["option"];
  }

  @override
  String toString() {
    // TODO: implement toString
    return '$name: $option';
  }
}

class ProductVariation {
  int id;
  String price;
  String regularPrice;
  String salePrice;
  bool onSale;
  bool inStock;
  String imageFeature;
  List<Attribute> attributes = [];

  ProductVariation();

  ProductVariation.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson["id"];
    price = parsedJson["price"];
    regularPrice = parsedJson["regular_price"];
    salePrice = parsedJson["sale_price"];
    onSale = parsedJson["on_sale"];
    inStock = parsedJson["in_stock"];
    imageFeature = parsedJson["image"]["src"];

    List<Attribute> attributeList = [];
    parsedJson["attributes"].forEach((item) {
      attributeList.add(Attribute.fromJson(item));
    });
    attributes = attributeList;
  }

  @override
  String toString() {
    String value = '';
    attributes.forEach((attribute) {
      value += '${attribute.name}: ${attribute.option},  ';
    });
    value = value.substring(0, value.length - 3);
    return value;
  }
}
