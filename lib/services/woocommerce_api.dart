import 'dart:async';
import "dart:collection";
import 'dart:convert';
import "dart:core";
import 'dart:io';
import "dart:math";
import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class QueryString {
  static Map parse(String query) {
    var search = new RegExp('([^&=]+)=?([^&]*)');
    var result = new Map();

    // Get rid off the beginning ? in query strings.
    if (query.startsWith('?')) query = query.substring(1);
    // A custom decoder.
    decode(String s) => Uri.decodeComponent(s.replaceAll('+', ' '));

    // Go through all the matches and build the result map.
    for (Match match in search.allMatches(query)) {
      result[decode(match.group(1))] = decode(match.group(2));
    }
    return result;
  }
}

class WooCommerceAPI {
  String url;
  String consumerKey;
  String consumerSecret;
  bool isHttps;

  WooCommerceAPI({this.url, this.consumerKey, this.consumerSecret}) {
    if (this.url.startsWith("https")) {
      this.isHttps = true;
    } else {
      this.isHttps = false;
    }
  }

  _getOAuthURL(String requestMethod, String endpoint) {
    var consumerKey = this.consumerKey;
    var consumerSecret = this.consumerSecret;

    var token = "";
    var url = this.url + "/wp-json/wc/v3/" + endpoint;
    var containsQueryParams = url.contains("?");

    // If website is HTTPS based, no need for OAuth, just return the URL with CS and CK as query params
    if (this.isHttps == true) {
      return url +
          (containsQueryParams == true
              ? "&consumer_key=" +
                  this.consumerKey +
                  "&consumer_secret=" +
                  this.consumerSecret
              : "?consumer_key=" +
                  this.consumerKey +
                  "&consumer_secret=" +
                  this.consumerSecret);
    }

    var rand = new Random();
    var codeUnits = new List.generate(10, (index) {
      return rand.nextInt(26) + 97;
    });

    var nonce = new String.fromCharCodes(codeUnits);
    int timestamp = (new DateTime.now().millisecondsSinceEpoch ~/ 1000).toInt();

    var method = requestMethod;
    var parameters = "oauth_consumer_key=" +
        consumerKey +
        "&oauth_nonce=" +
        nonce +
        "&oauth_signature_method=HMAC-SHA1&oauth_timestamp=" +
        timestamp.toString() +
        "&oauth_token=" +
        token +
        "&oauth_version=1.0&";

    if (containsQueryParams == true) {
      parameters = parameters + url.split("?")[1];
    } else {
      parameters = parameters.substring(0, parameters.length - 1);
    }

    Map<dynamic, dynamic> params = QueryString.parse(parameters);
    Map<dynamic, dynamic> treeMap = new SplayTreeMap<dynamic, dynamic>();
    treeMap.addAll(params);

    String parameterString = "";

    for (var key in treeMap.keys) {
      parameterString = parameterString +
          Uri.encodeQueryComponent(key) +
          "=" +
          treeMap[key] +
          "&";
    }

    parameterString = parameterString.substring(0, parameterString.length - 1);

    var baseString = method +
        "&" +
        Uri.encodeQueryComponent(
            containsQueryParams == true ? url.split("?")[0] : url) +
        "&" +
        Uri.encodeQueryComponent(parameterString);

    var signingKey = consumerSecret + "&" + token;

    var hmacSha1 =
        new crypto.Hmac(crypto.sha1, utf8.encode(signingKey)); // HMAC-SHA1
    var signature = hmacSha1.convert(utf8.encode(baseString));

    var finalSignature = base64Encode(signature.bytes);

    var requestUrl = "";

    if (containsQueryParams == true) {
      requestUrl = url.split("?")[0] +
          "?" +
          parameterString +
          "&oauth_signature=" +
          Uri.encodeQueryComponent(finalSignature);
    } else {
      requestUrl = url +
          "?" +
          parameterString +
          "&oauth_signature=" +
          Uri.encodeQueryComponent(finalSignature);
    }

//    print('network: $requestUrl');

    return requestUrl;
  }

  Future<dynamic> getAsync(String endPoint) async {
//    debugPrint('int woocommerceAPI getAsync method');
    var url = this._getOAuthURL("GET", endPoint);

    final response = await http.get(url);

    return json.decode(response.body);
  }

  Future<dynamic> postAsync(String endPoint, Map data) async {
    var url = this._getOAuthURL("POST", endPoint);

    var client = new http.Client();
    var request = new http.Request('POST', Uri.parse(url));
    request.headers[HttpHeaders.contentTypeHeader] =
        'application/json; charset=utf-8';
    request.headers[HttpHeaders.cacheControlHeader] = "no-cache";
    request.body = json.encode(data);
    var response =
        await client.send(request).then((res) => res.stream.bytesToString());
    var dataResponse = await json.decode(response);
    return dataResponse;
  }

  Future<dynamic> putAsync(String endPoint, Map data) async {
    var url = this._getOAuthURL("PUT", endPoint);

    var client = new http.Client();
    var request = new http.Request('PUT', Uri.parse(url));
    request.headers[HttpHeaders.contentTypeHeader] =
        'application/json; charset=utf-8';
    request.headers[HttpHeaders.cacheControlHeader] = "no-cache";
    request.body = json.encode(data);
    var response =
        await client.send(request).then((res) => res.stream.bytesToString());
    var dataResponse = await json.decode(response);
    return dataResponse;
  }

  void dispose() {}
}
